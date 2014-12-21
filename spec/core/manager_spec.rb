require 'spec_helper'

module Nucleon

  describe Manager do

    include_context "nucleon_test"
    include_context "nucleon_plugin"
    #***************************************************************************
    def manager(*args, &code)
      test_object(Manager, *args, &code)
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
          dbg(manager.environments)
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
      
      it "is an example" do
        manager("Nucleon::Manager::config",true) do |manager|
          manager.define_type :nucleon, :test, :first
          manager.define_type :unit, :test, :first
          manager.define_type :testing, :test, :first
          test_eq manager.namespaces, [:nucleon, :unit, :testing]
        end
      end
    end
    
    
  end
end