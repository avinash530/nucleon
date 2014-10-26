module Nucleon
#
# == Plugin environment
#
# The Nucleon::Environment class defines a container for registered plugins and
# autoloaded providers.
#
# One of the primary functions of the Nucleon library is to provide a very
# flexible extensible architectural base for Ruby applications needing ready
# made modularity.  To fulfill our objectives, the Nucleon library defines
# plugin managers managed as a global multition.
#
# These managers should be able to fail gracefully and recover to the state
# they left off if a plugin provider crashes.  To acomplish this, each manager
# is a Celluloid actor that manages a globally defined environment (also within
# a multition).  This environment contains all of the plugins and providers
# that they manager has registered and loaded.
#
# Three collections are managed:
#
# 1. Defined plugin types
#
#    The environment maintains a collection of registered plugin types with a
#    default provider.  Default providers can easily be changed in runtime as
#    needs change.
#
# 2. Plugin load info
#
#    Whenever a plugin is defined and initialized by the manager a specification
#    is created and maintained that lets the manager know details about the
#    plugin, such as where the base plugin resides, namespace, type, etc...
#
# 3. Active plugins
#
#    The environment maintains a registry of all of the plugin instances across
#    the application.  These active plugins are accessed by the manager, usually
#    through the facade.  When we work with plugins in the application, we are
#    usually working with these instances.
#
#
# See also:
# - Nucleon::Manager
#
class Environment < Core

  #*****************************************************************************
  # Constructor / Destructor

  # Initialize a new Nucleon environment
  #
  # IMORTANT:  The environment constructor should accept no parameters!
  #
  # * *Parameters*
  #
  # * *Returns*
  #   - [Void]  This method does not return a value
  #
  # * *Errors*
  #
  # See also:
  # - Nucleon::Manager
  #
  def initialize
    super({
      :plugin_types => {},
      :load_info    => {},
      :active_info  => {}
    }, {}, true, true, false)
  end

  #*****************************************************************************
  # Plugin type accessor / modifiers

  def namespaces
    get_hash(:plugin_types).keys
  end

  def plugin_types(namespace)
    get_hash([ :plugin_types, namespace ]).keys
  end

  def define_plugin_type(namespace, plugin_type, default_provider = nil)
    set([ :plugin_types, namespace, sanitize_id(plugin_type) ], default_provider)
  end

  def define_plugin_types(namespace, type_info)
    if type_info.is_a?(Hash)
      type_info.each do |plugin_type, default_provider|
        define_plugin_type(namespace, plugin_type, default_provider)
      end
    end
  end

  def plugin_type_defined?(namespace, plugin_type)
    get_hash([ :plugin_types, namespace ]).has_key?(sanitize_id(plugin_type))
  end

  def plugin_type_default(namespace, plugin_type)
    get([ :plugin_types, namespace, sanitize_id(plugin_type) ])
  end


  #*****************************************************************************
  # Loaded plugin accessor / modifiers

  def define_plugin(namespace, plugin_type, base_path, file, &code)
    namespace   = namespace.to_sym
    plugin_type = sanitize_id(plugin_type)
    plugin_info = parse_plugin_info(namespace, plugin_type, base_path, file)

    unless get_hash([ :load_info, namespace, plugin_type ]).has_key?(plugin_info[:provider])
      data = {
        :namespace        => namespace,
        :type             => plugin_type,
        :base_path        => base_path,
        :file             => file,
        :provider         => plugin_info[:provider],
        :directory        => plugin_info[:directory],
        :class_components => plugin_info[:class_components]
      }
      code.call(data) if code

      set([ :load_info, namespace, plugin_type, plugin_info[:provider] ], data)
    end
  end

  def loaded_plugin(namespace, plugin_type, provider)
    get([ :load_info, namespace, sanitize_id(plugin_type), sanitize_id(provider) ], nil)
  end

  def loaded_plugins(namespace = nil, plugin_type = nil, provider = nil, default = {})
    load_info   = get_hash(:load_info)

    namespace   = namespace.to_sym if namespace
    plugin_type = sanitize_id(plugin_type) if plugin_type
    provider    = sanitize_id(provider) if provider
    results     = default

    if namespace && load_info.has_key?(namespace)
      if plugin_type && load_info[namespace].has_key?(plugin_type)
        if provider && load_info[namespace][plugin_type].has_key?(provider)
          results = load_info[namespace][plugin_type][provider]
        elsif ! provider
          results = load_info[namespace][plugin_type]
        end
      elsif ! plugin_type
        results = load_info[namespace]
      end
    elsif ! namespace
      results = load_info
    end
    results
  end

  def plugin_has_type?(namespace, plugin_type)
    get_hash([ :load_info, namespace ]).has_key?(sanitize_id(plugin_type))
  end

  def plugin_has_provider?(namespace, plugin_type, provider)
    get_hash([ :load_info, namespace, sanitize_id(plugin_type) ]).has_key?(sanitize_id(provider))
  end

  #*****************************************************************************
  # Active plugin accessor / modifiers

  def create_plugin(namespace, plugin_type, provider, options = {}, &code)
    namespace   = namespace.to_sym
    plugin_type = sanitize_id(plugin_type)
    provider    = sanitize_id(provider)
    plugin      = nil

    unless plugin_type_defined?(namespace, plugin_type)
      return plugin
    end

    if type_info = loaded_plugin(namespace, plugin_type, provider)
      ids             = array(type_info[:class].register_ids).flatten
      instance_config = Config.new(options)
      ensure_new      = instance_config.delete(:new, false)

      instance_options = Util::Data.subset(instance_config.export, ids, true)
      instance_name    = "#{provider}_" + Nucleon.sha1(instance_options)
      plugin           = get([ :active_info, namespace, plugin_type, instance_name ])

      if ensure_new || ! ( instance_name && plugin )
        type_info[:instance_name] = instance_name

        options = code.call(type_info, options) if code
        options.delete(:new)

        plugin = type_info[:class].new(namespace, plugin_type, provider, options)
        set([ :active_info, namespace, plugin_type, instance_name ], plugin)
      end
    end
    plugin
  end

  def get_plugin(namespace, plugin_type, plugin_name)
    namespace   = namespace.to_sym
    plugin_type = sanitize_id(plugin_type)

    get_hash([ :active_info, namespace, plugin_type ]).each do |instance_name, plugin|
      if plugin.plugin_name.to_s == plugin_name.to_s
        return plugin
      end
    end
    nil
  end

  def remove_plugin(namespace, plugin_type, instance_name, &code)
    plugin = delete([ :active_info, namespace, sanitize_id(plugin_type), instance_name ])
    code.call(plugin) if code && plugin
    plugin
  end

  def active_plugins(namespace = nil, plugin_type = nil, provider = nil)
    active_info = get_hash(:active_info)

    namespace   = namespace.to_sym if namespace
    plugin_type = sanitize_id(plugin_type) if plugin_type
    provider    = sanitize_id(provider) if provider
    results     = {}

    if namespace && active_info.has_key?(namespace)
      if plugin_type && active_info[namespace].has_key?(plugin_type)
        if provider && ! active_info[namespace][plugin_type].keys.empty?
          active_info[namespace][plugin_type].each do |instance_name, plugin|
            plugin                 = active_info[namespace][plugin_type][instance_name]
            results[instance_name] = plugin if plugin.plugin_provider == provider
          end
        elsif ! provider
          results = active_info[namespace][plugin_type]
        end
      elsif ! plugin_type
        results = active_info[namespace]
      end
    elsif ! namespace
      results = active_info
    end
    results
  end

  #*****************************************************************************
  # Utilities

  def class_name(name, separator = '::', want_array = FALSE)
    components = []

    case name
    when String, Symbol
      components = name.to_s.split(separator)
    when Array
      components = name
    end

    components.collect! do |value|
      value    = value.to_s.strip
      value[0] = value.capitalize[0] if value =~ /^[a-z]/
      value
    end

    if want_array
      return components
    end
    components.join(separator)
  end

  #---

  def class_const(name, separator = '::')
    components = class_name(name, separator, TRUE)
    constant   = Object

    components.each do |component|
      constant = constant.const_defined?(component) ?
                  constant.const_get(component) :
                  constant.const_missing(component)
    end
    constant
  end

  #---

  def sanitize_id(id_component)
    id_component.to_s.gsub(/([a-z0-9])(?:\-|\_)?([A-Z])/, '\1_\2').downcase.to_sym
  end
  protected :sanitize_id

  #---

  def sanitize_class(class_component)
    class_component.to_s.split('_').collect {|elem| elem.slice(0,1).capitalize + elem.slice(1..-1) }.join('')
  end
  protected :sanitize_class

  #---

  def plugin_class(namespace, plugin_type)
    class_const([ sanitize_class(namespace), :plugin, sanitize_class(plugin_type) ])
  end

  #---

  def parse_plugin_info(namespace, plugin_type, base_path, file)
    dir_components   = base_path.split(File::SEPARATOR)
    file_components  = file.split(File::SEPARATOR)

    file_name        = file_components.pop.sub(/\.rb/, '')
    directory        = file_components.join(File::SEPARATOR)

    file_class       = sanitize_class(file_name)
    group_components = directory.sub(/^#{base_path}#{File::SEPARATOR}?/, '').split(File::SEPARATOR)

    class_components = [ sanitize_class(namespace), sanitize_class(plugin_type) ]

    if ! group_components.empty?
      group_name       = group_components.collect {|elem| elem.downcase  }.join('_')
      provider         = [ group_name, file_name ].join('_')

      group_components = group_components.collect {|elem| sanitize_class(elem) }
      class_components = [ class_components, group_components, file_class ].flatten
    else
      provider         = file_name
      class_components = [ class_components, file_class ].flatten
    end

    {
      :directory        => directory,
      :provider         => sanitize_id(provider),
      :class_components => class_components
    }
  end
  protected :parse_plugin_info
end
end
