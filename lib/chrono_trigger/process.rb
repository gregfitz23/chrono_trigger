module ChronoTrigger
  
  class Process

    def run(options={})
      @t = Thread.new do
        shell = ChronoTrigger::Shell.new
        shell.load_triggers(options[:trigger_file])
        loop do
          shell.execute_triggers
          sleep 1.minute.to_i
        end
      end
      
      @t.join
    end
    
    def stop
      @t.exit
    end
  end    
end