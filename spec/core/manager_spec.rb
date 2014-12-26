require 'spec_helper'

module Nucleon

  describe Manager do

    include_context "nucleon_test"
    include_context "nucleon_plugin"
    #***************************************************************************
    def manager(*args, &code)
      test_object(Manager, *args, &code)
    end
    
    def test_loaded_plugin(manager, plugin_type, provider_map)
      plugin_define_plugins(manager, plugin_type, provider_map) do |type, provider|
        plugin_info = manager.loaded_plugin(:nucleon, type, provider)
        test_eq plugin_info, plugin_loaded_plugins[:nucleon][type][provider]
      end
    end
    
    def test_loaded_plugins(manager, plugin_type, provider_map)
      plugin_define_plugins(manager, plugin_type, provider_map)
      test_eq manager.loaded_plugins[:nucleon][plugin_type], plugin_loaded_plugins[:nucleon][plugin_type]    
    end    
        
    #
    # Accessor for the global supervisors (mostly for testing purposes)
    #

    describe "#supervisors" do

      it "returns a Hash" do
        #validated return type alone
        test_type Manager.supervisors, Hash
        #memory location value keeps on changing . Do we need to validate this data ?
        Nucleon.dump_enabled=true
        dbg(Manager.supervisors)
        Nucleon.dump_enabled=false
      end
    end

    #
    # Accessor for the global plugin manager environments (mostly for testing purposes)
    #

    describe "#environments" do

      it "returns a Hash" do
        #validated return type alone
        test_type Manager.environments, Hash
        #memory location value keeps on changing . How can we validate the data ?
        Nucleon.dump_enabled=true
          dbg(Manager.environments)
        Nucleon.dump_enabled=false
      end
    end

    #*****************************************************************************
    # Plugin manager interface

    # Return a specified plugin manager instance
    #

    describe "#connection" do

      it "is an example" do
        #validated return type alone
        test_type Manager.connection(:config,true), Nucleon::Manager
         #memory location value keeps on changing . How can we validate the data ?
        Nucleon.dump_enabled=true
          dbg(Manager.connection(:config,true))
        Nucleon.dump_enabled=false
        
      end
    end

    # Initialize a new Nucleon environment
    #

    describe"#initialize" do
      
      it "is an example" do
        #validated return type alone
        test_type manager("Nucleon::Manager::config",true), Nucleon::Manager
        # memory location value keeps on changing . How can we validate the data ?
        # Am I doing this right till here?
        # Is the actor_id value given by me is a valid one? What sort of values can I pass for actor_id
        Nucleon.dump_enabled=true
          dbg(manager("Nucleon::Manager::config",true))
        Nucleon.dump_enabled=false
      end
    end
    
    # Perform any cleanup operations during manager shutdown
    #   
    
    describe"parallel_finalize" do
      
      it "is an example" do
        #validated return type alone
        test_type manager("Nucleon::Manager::config",true).parallel_finalize, Hash
        # As parallel_finalize willnot return any value jus validating the value to {}. Is that fine?
        Nucleon.dump_enabled=true
          test_eq manager("Nucleon::Manager::config",true).parallel_finalize, {}          
        Nucleon.dump_enabled=false
      end
    end
    
    # Return a reference to self
    #
    
    describe "#myself" do
      
      it "returns a self reference" do
        #validated return type alone
        #Hope this validation is fine for this Test Case. Please confirm.
        test_type manager("Nucleon::Manager::config",false).myself, Nucleon::Manager
      end
    end 
    
    # Return true as a test method for checking for running manager
    #
    
    describe "#test_connection" do
      
      it "returns the true value" do
        #Please confirm any other scenario needs to be covered
        test_eq manager("Nucleon::Manager::config",false).test_connection, true
      end
    end
    
    #*****************************************************************************
    # Plugin model accessors / modifiers
  
    # Return all of the defined namespaces in the plugin environment.
    #
    
    describe "#namespaces" do
      
      it "returns all the defined namespaces" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_type :nucleon, :test, :first
          manager.define_type :unit, :test, :first
          manager.define_type :testing, :test, :first
          test_eq manager.namespaces, [:nucleon, :unit, :testing]
        end
      end
    end
    
    # Return all of the defined plugin types in a plugin namespace.
    #
    
    describe "#types" do
      
      it "returns all the defined types in a plugin namespace" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_type :nucleon, :test, :first
          manager.define_type :nucleon, :test1, :second
          manager.define_type :nucleon, :test2, :third
          test_eq manager.types(:nucleon), [:test, :test1, :test2]
        end
      end
    end
    
    # Define a new plugin type in a specified namespace.
    #
    
    describe "#define_type" do
      
      it "is an example" do
        # Validating Return Type right now. 
        # Do we need to validate Return value if so memory location value keeps on changing . Do we need to validate this data ? . export not working 
        manager("Nucleon::Manager::config",true) do |manager|
          test_type manager.define_type(:nucleon, :test, :first), Nucleon::Manager
        end
      end
    end
    
    # Define one or more new plugin types in a specified namespace.
    #
    
    describe "#define_types" do
      
      it "returns an Environment object" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_type manager.define_types(:nucleon, { :test1 => "test2", :test3 => "test4"}), Nucleon::Environment
        end
      end
      
      it "returns loaded plugin state" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_config manager.define_types(:nucleon, { :test1 => "test2", :test3 => "test4"}), plugin_environment_test2
        end
      end
    end
    
    # Check if a specified plugin type has been defined
    #
    
    describe "#type_defined?" do
      
      it "returns true for the existing plugin type" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_types(:nucleon, { :test1 => "test2", :test3 => "test4"})
          manager.define_type(:nucleon, :test, :first)
          manager.define_type :nucleon, :test2, :third
          test_eq manager.type_defined?(:nucleon, :test3), true
          test_eq manager.type_defined?(:nucleon, :test2), true
        end
      end
      
      it "returns false for the non existing plugin type" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_types(:nucleon, { :test1 => "test2", :test3 => "test4"})
          manager.define_type(:nucleon, :test, :first)
          manager.define_type :nucleon, :test2, :third
          test_eq manager.type_defined?(:nucleon, :test4), false
          test_eq manager.type_defined?(:nucleon1, :test2), false
        end
      end      
    end
    
    # Return the default provider currently registered for a plugin type
    #
    
    describe "#type_default" do
      
      it "returns default provider for defined plugin type" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_types(:nucleon, { :test1 => "test2", :test3 => "test4"})
          manager.define_type(:nucleon, :test, :first)
          manager.define_type :nucleon, :test2, :third          
          test_eq manager.type_default(:nucleon, :test2), :third
        end
      end
      
      it "returns nil for undefined plugin type" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_eq manager.type_default(:nucleon, :test2), nil
        end  
      end
    end
    
    # Return the load information for a specified plugin provider if it exists
    #
    
    describe "#loaded_plugin" do
      it "load info of translator plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :translator, {:json => 'JSON', :yaml => 'YAML' })
        end
      end

      
      it "load info of template plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :template, { :json => 'JSON', :yaml => 'YAML', :wrapper => 'wrapper' })
        end
      end
      
      it "load info of project plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :project, { :git => 'git', :github => 'github' }) 
        end
      end
      
      it "load info of extension plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :extension, { :project => 'project' })
        end        
      end
      
      it "load info of event plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :event, { :regex => 'regex' })  
        end        
      end
      
      it "load info of command plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugin(manager, :command, { :bash => 'bash' })  
        end        
      end
      
      it "load info of action - project plugins" do
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_define_plugins(manager, :action, { :project_update => [ 'project', 'update' ], :project_ceate => [ 'project', 'create' ], :project_save => [ 'project', 'save' ], 
                                                    :project_remove => [ 'project', 'remove' ], :project_add => [ 'project',  'add' ],:extract => 'extract' })
        end         
      end      
    end
    
    # Return the load information for namespaces, plugin types, providers if it exists
    # 
    
    describe "#loaded_plugins" do
      
      it "returns loaded plugins for nil params" do
        test_eq manager("Nucleon::Manager::config",true).loaded_plugins, {}
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_define_plugins(manager, :project, { :github => 'github', :git => 'git' })
          plugin_define_plugins(manager, :event, { :regex => 'regex' })
          plugin_define_plugins(manager, :extension, { :project => 'project' })
          plugin_define_plugins(manager, :command, { :bash => 'bash' })
          plugin_define_plugins(manager, :translator, { :json => 'JSON', :yaml => 'YAML' })
          plugin_define_plugins(manager, :action, { :project_update => [ 'project', 'update' ], :project_ceate => [ 'project', 'create' ], :project_save => [ 'project', 'save' ], 
                                                    :project_remove => [ 'project', 'remove' ], :project_add => [ 'project',  'add' ],:extract => 'extract' }) 
          plugin_define_plugins(manager, :template, { :json => 'JSON', :yaml => 'YAML', :wrapper => 'wrapper' })
          
          test_eq manager.loaded_plugins, plugin_loaded_plugins
        end
      end
      
      it "returns loaded translator plugins provided namespace alone" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugins manager, :translator,{ :json => 'JSON', :yaml => 'YAML' }
        end
      end
      
      it "returns loaded template plugins provide namespace alone" do
        manager("Nucleon::Manager::config",true) do |manager|
          test_loaded_plugins manager, :template,{ :json => 'JSON', :wrapper => 'wrapper', :yaml => 'YAML' }  
        end
      end
      
      it "returns loaded project plugins provide namespace alone" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :project,{ :git => 'git', :github => 'github' }
      end
      
      it "returns loaded extension plugins provide namespace alone" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :extension,{ :project => 'project' }
      end

      it "returns loaded event plugins provide namespace alone" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :event,{ :regex => 'regex' }
      end
      
      it "returns loaded command plugins provide namespace alone" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :command,{ :bash => 'bash' }
      end
      
      it "returns action command plugins provide namespace alone" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :action,{ :project_update => [ 'project', 'update' ], :project_save => [ 'project', 'save' ], :project_remove => [ 'project', 'remove' ], 
                                                    :project_ceate => [ 'project', 'create' ],:project_add => [ 'project',  'add' ],:extract => 'extract' }
      end

      it "returns loaded translator plugins provided namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :translator,{ :json => 'JSON', :yaml => 'YAML' }
      end
      
      it "returns loaded template plugins provide namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :template,{ :json => 'JSON', :wrapper => 'wrapper', :yaml => 'YAML' }
      end
      
      it "returns loaded project plugins provide namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :project,{ :git => 'git', :github => 'github' }
      end
      
      it "returns loaded extension plugins provide namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :extension,{ :project => 'project' }
      end

      it "returns loaded event plugins provide namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :event,{ :regex => 'regex' }
      end
      
      it "returns loaded command plugins provide namespace and plugin type" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :command,{ :bash => 'bash' }
      end
      
      it "returns action command plugins provide namespace and plugin type" do
        test_loaded_plugins manager("Nucleon::Manager::config",true), :action,{ :project_update => [ 'project', 'update' ], :project_save => [ 'project', 'save' ], :project_remove => [ 'project', 'remove' ], 
                                                              :project_ceate => [ 'project', 'create' ],:project_add => [ 'project',  'add' ],:extract => 'extract' }
      end

      it "returns loaded translator plugins provided namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :translator,{ :json => 'JSON', :yaml => 'YAML' }
      end
      
      it "returns loaded template plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :template,{ :json => 'JSON', :wrapper => 'wrapper', :yaml => 'YAML' }
      end
      
      it "returns loaded project plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :project,{ :git => 'git', :github => 'github' }
      end
      
      it "returns loaded extension plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :extension,{ :project => 'project' }
      end

      it "returns loaded event plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :event,{ :regex => 'regex' }
      end
      
      it "returns loaded command plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :command,{ :bash => 'bash' }
      end
      
      it "returns action command plugins provide namespace ,plugin type and provider" do
         test_loaded_plugins manager("Nucleon::Manager::config",true), :action,{ :project_update => [ 'project', 'update' ], :project_save => [ 'project', 'save' ], :project_remove => [ 'project', 'remove' ], 
                                                              :project_ceate => [ 'project', 'create' ],:project_add => [ 'project',  'add' ],:extract => 'extract' }
      end      
    end
    
    # Define a new plugin provider of a specified plugin type.
    #
    
    describe "#define_plugin" do
      
      it "registers translator plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :translator, { :json => 'JSON', :yaml => 'YAML' }),
                {:json=>"JSON", :yaml=>"YAML"}
      end
      
       it "registers template plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :template, { :json => 'JSON', :yaml => 'YAML', :wrapper => 'wrapper' }),
                {:json=>"JSON", :yaml=>"YAML", :wrapper=>"wrapper"}
      end
      
      it "registers project plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :project, { :git => 'git', :github => 'github' }),
                { :git => 'git', :github => 'github' }
      end
      
      it "registers extension plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :extension, { :project => 'project' }),
                { :project => 'project' }
      end
      
      it "registers event plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :event, { :regex => 'regex' }),
                { :regex => 'regex' }
      end
      
      it "registers command plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :command, { :bash => 'bash' }),
                { :bash => 'bash' }
      end
      
      it "registers action plugins" do
        test_eq plugin_define_plugins(manager("Nucleon::Manager::config",true), :action, { :project_update => [ 'project', 'update' ], :project_ceate => [ 'project', 'create' ], :project_save => [ 'project', 'save' ], 
                                             :project_remove => [ 'project', 'remove' ], :project_add => [ 'project',  'add' ],:extract => 'extract' }),
                { :project_update => [ 'project', 'update' ], :project_ceate => [ 'project', 'create' ], :project_save => [ 'project', 'save' ], 
                                             :project_remove => [ 'project', 'remove' ], :project_add => [ 'project',  'add' ],:extract => 'extract' }                                          
      end      
    end
    
    # Check if a specified plugin provider has been loaded
    #
    
    describe "#plugin_has_provider?" do
      
      it "returns true for a loded plugin and provider" do
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_define_plugins manager, :translator,{ :json => 'JSON' }
          test_eq manager.plugin_has_provider?(:nucleon, :translator, :json), true
        end
      end
  
      it "returns false for a non loded plugin and provider" do
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_define_plugins manager, :action,{ :project_update => [ 'project', 'update' ], :project_save => [ 'project', 'save' ], :project_remove => [ 'project', 'remove' ], 
                                                           :project_add => [ 'project',  'add' ],:extract => 'extract' }
          test_eq manager.plugin_has_provider?(:nucleon, :action, :project_ceate), false  
        end
      end
    end
    
    # Return active plugins for namespaces, plugin types, providers if specified
    #
    
    describe "#active_plugins" do
      #Unable to use .export with the below manager object. So I commented line 385, 396 in nucleon_plugin.rb
      it "returns appropriate return type" do     
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_autoload_test_manager(manager)
          manager.create(:nucleon, :test, :first, { :test1 => 13, :test2 => 5})
          manager.create(:nucleon, :test, :second, { :test1 => 15 })
          test_type(manager.active_plugins, Hash)
          test_type(manager.active_plugins(:nucleon), Hash)
          test_type(manager.active_plugins(:nucleon, :test), Hash)
          test_type(manager.active_plugins(:nucleon, :test, :first), Hash)
          test_type((manager.active_plugins(:nucleon, :test)[:first_bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f]), Nucleon::Test::First)
        end
        
      end
      
      it "returns appropriate return value" do
        manager("Nucleon::Manager::config",true) do |manager|
          plugin_autoload_test_manager(manager)
          manager.create(:nucleon, :test, :first, { :test1 => 13, :test2 => 5})
          manager.create(:nucleon, :test, :second, { :test1 => 15 })
          test_config((manager.active_plugins[:nucleon][:test][:first_bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f]), {:test1=>13, :test2=>5})
        end
      end
    end
  end
end