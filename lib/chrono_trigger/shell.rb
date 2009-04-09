module ChronoTrigger
  
  class ConfigurationException < Exception; end
  
  class Shell
    
    DEFAULT_TRIGGERS = "lib/triggers/*.rb"
    #Load triggers defined in the trigger files by evaluating them in the context of this Shell instance.
    def load_triggers(files = Dir.glob("#{DEFAULT_TRIGGERS}"))
      files.each { |file| self.instance_eval(File.read(file), file) }
    end
    
    #Instantiate a trigger and evaluate the passed in block in the context of the trigger.
    #This is the initial method call when setting up a configuration using the DSL. 
    def trigger(name, &block)
      raise ConfigurationException.new("No configuration specified for trigger #{name}") unless block_given?
      
      trigger = Trigger.new(name)
      trigger.instance_eval(&block)
      
      triggers << trigger
      trigger
    end
    
    #Run execute on any trigger who's cron entry matches the current time.
    def execute_triggers
      now = Time.now
      STDOUT.puts "triggers: #{triggers}"
      triggers.map {|trigger| trigger.execute_on_match(now)}
    end
    
    def triggers
      @triggers ||= []
    end
    
  end
end