module ChronoTrigger
  class Trigger
    
    def runs(&block)
      @exec_block = block
    end
    
    def on
      
    end
    
    def dates
      @dates ||= []
    end
    
    def execute
      @exec_block.call
    end
  
  end
end