module ChronoTrigger
  
  class ConfigurationException < Exception; end
  
  class Shell
    
    def trigger(&block)
      raise ConfigurationException unless block_given?
      
      trigger = Trigger.new
      trigger.instance_eval(&block)
      
      triggers << trigger
      trigger
    end
    
    def triggers
      @triggers ||= []
    end
    
  end
end