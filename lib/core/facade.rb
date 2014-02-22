
module Nucleon
module Facade
 
  def ui
    Core.ui
  end
  
  def quiet=quiet
    Util::Console.quiet = quiet  
  end
  
  #---
  
  def logger
    Core.logger
  end
  
  def log_level
    Util::Logger.level
  end
  
  def log_level=log_level
    Util::Logger.level = log_level
  end
  
  #-----------------------------------------------------------------------------
  
  def admin?
    is_admin  = ( ENV['USER'] == 'root' )
    ext_admin = exec(:check_admin) do |op, results|
      if op == :reduce
        results.values.include?(true)
      else
        results ? true : false
      end
    end
    is_admin || ext_admin ? true : false
  end
  
  #-----------------------------------------------------------------------------
  # Status codes
  
  @@codes = Codes.new
  
  def code
    @@codes
  end
  
  def codes(*codes)
    Codes.codes(*codes)
  end
  
  #-----------------------------------------------------------------------------
  # Core plugin interface
  
  def reload(core = false)
    Manager.connection.reload(core)  
  end
  
  #---
  
  def namespaces
    Manager.connection.namespaces
  end
  
  def define_namespace(*namespaces)
    Manager.connection.namespace(*namespaces) 
  end
  
  #---
  
  def types
    Manager.connection.types
  end
  
  def define_type(type_info)
    Manager.connection.define_type(type_info)
  end
   
  def type_default(type)
    Manager.connection.type_default(type)
  end
  
  #---
  
  def register(base_path, &code)
    Manager.connection.register(base_path, &code)
    Manager.connection.autoload
  end
  
  def loaded_plugins(type = nil, provider = nil)
    Manager.connection.loaded_plugins(type, provider)    
  end
  
  #---
  
  def active_plugins(type = nil, provider = nil)
    Manager.connection.plugins(type, provider)    
  end
  
  #---
  
  def plugin(type, provider, options = {})
    Manager.connection.load(type, provider, options)
  end
  
  #---
  
  def plugins(type, data, build_hash = false, keep_array = false)
    Manager.connection.load_multiple(type, data, build_hash, keep_array)
  end
  
  #---
  
  def get_plugin(type, name)
    Manager.connection.get(type, name)
  end
  
  #---
  
  def remove_plugin(plugin)
    Manager.connection.remove(plugin)
  end
  
  #---
  
  def plugin_class(type)
    Manager.connection.plugin_class(type)
  end
  
  #---
  
  def provider_class(namespace, type, provider)
    Manager.connection.provider_class(namespace, type, provider)  
  end
    
  #-----------------------------------------------------------------------------
  # Core plugin type facade
  
  def extension(provider)
    plugin(:extension, provider, {})
  end
  
  #---
  
  def action(provider, options)
    plugin(:action, provider, options)
  end
  
  def actions(data, build_hash = false, keep_array = false)
    plugins(:action, data, build_hash, keep_array)  
  end
  
  def action_config(provider)
    action(provider, { :settings => {}, :quiet => true }).configure
  end
  
  def action_run(provider, options = {}, quiet = true)
    Plugin::Action.exec(provider, options, quiet)
  end
  
  def action_cli(provider, args = [], quiet = false, name = :nucleon)
    Plugin::Action.exec_cli(provider, args, quiet, name)
  end
  
  #---
  
  def project(options, provider = nil)
    plugin(:project, provider, options)
  end
  
  def projects(data, build_hash = false, keep_array = false)
    plugins(:project, data, build_hash, keep_array)
  end
   
  #-----------------------------------------------------------------------------
  # Utility plugin type facade
  
  def command(options, provider = nil)
    plugin(:command, provider, options)
  end
  
  def commands(data, build_hash = false, keep_array = false)
    plugins(:command, data, build_hash, keep_array)
  end
   
  #---
  
  def event(options, provider = nil)
    plugin(:event, provider, options)
  end
  
  def events(data, build_hash = false, keep_array = false)
    plugins(:event, data, build_hash, keep_array)
  end
  
  #---
  
  def template(options, provider = nil)
    plugin(:template, provider, options)
  end
  
  def templates(data, build_hash = false, keep_array = false)
    plugins(:template, data, build_hash, keep_array)
  end
   
  #---
  
  def translator(options, provider = nil)
    plugin(:translator, provider, options)
  end
  
  def translators(data, build_hash = false, keep_array = false)
    plugins(:translator, data, build_hash, keep_array)
  end
  
  #-----------------------------------------------------------------------------
  # Plugin extensions
   
  def exec(method, options = {}, &code)
    Manager.connection.exec(method, options, &code)
  end
  
  #---
  
  def config(type, options = {})
    Manager.connection.config(method, options)
  end
  
  #---
  
  def check(method, options = {})
    Manager.connection.check(method, options)
  end
  
  #---
  
  def value(method, value, options = {})
    Manager.connection.value(method, value, options)
  end
  
  #---
  
  def collect(method, options = {})
    Manager.connection.collect(method, options)
  end
        
  #-----------------------------------------------------------------------------
  # External execution
   
  def run
    begin
      logger.debug("Running contained process at #{Time.now}")
      yield
      
    rescue Exception => error
      logger.error("Nucleon run experienced an error! Details:")
      logger.error(error.inspect)
      logger.error(error.message)
      logger.error(Util::Data.to_yaml(error.backtrace))
  
      ui.error(error.message) if error.message
      raise
    end
  end
  
  #---
    
  def cli_run(command, options = {}, &code)
    command = command.join(' ') if command.is_a?(Array)
    config  = Config.ensure(options)
    
    logger.info("Executing command #{command}")
        
    result = Util::Shell.connection.exec(command, config, &code)
    
    unless result.status == Nucleon.code.success
      ui.error("Command #{command} failed to execute")
    end     
    result
  end
  
  #---
  
  def executable(args, name = 'nucleon') #ARGV
    Signal.trap("INT") { exit 1 }

    logger.info("`#{name}` invoked: #{args.inspect}")

    $stdout.sync = true
    $stderr.sync = true

    begin
      logger.debug("Beginning execution run")
  
      arg_components = Util::CLI::Parser.split(args, "#{name} <action> [ <arg> ... ]")
      main_command   = arg_components.shift
      sub_command    = arg_components.shift
      sub_args       = arg_components
  
      if main_command.processed && sub_command
        exit_status = action_cli(sub_command, sub_args, false, name)
      else
        puts I18n.t('nucleon.core.exec.help.usage') + ': ' + main_command.help + "\n"
        puts I18n.t('nucleon.core.exec.help.header') + ":\n\n"
    
        loaded_plugins(:action).each do |provider, action|
          puts sprintf("   %-10s : %s\n", 
            "<#{provider}>", 
            action(provider, { :settings => {}, :quiet => true }).help
          )
        end
    
        puts "\n" + I18n.t('nucleon.core.exec.help.footer') + "\n\n"   
        exit_status = code.help_wanted  
      end 
  
    rescue Exception => error
      logger.error("Nucleon executable experienced an error:")
      logger.error(error.inspect)
      logger.error(error.message)
      logger.error(Util::Data.to_yaml(error.backtrace))

      ui.error(error.message, { :prefix => false }) if error.message
  
      exit_status = error.status_code if error.respond_to?(:status_code)
    end
    exit_status
  end
  
  #-----------------------------------------------------------------------------
  # Utilities
  
  def class_name(name, separator = '::', want_array = false)
    Manager.connection.class_name(name, separator, want_array)
  end
  
  #---
  
  def class_const(name, separator = '::')
    Manager.connection.class_const(name, separator)
  end
  
  #---
  
  def sha1(data)
    Digest::SHA1.hexdigest(Util::Data.to_json(data, false))
  end  
end
end

