module ChronoTrigger
  
  class Process

    def run(options={})
      @t = Thread.new do
        setup(options)
        
        shell = ChronoTrigger::Shell.new
        options[:trigger_files] ? shell.load_triggers(options[:trigger_files].split(":")) : shell.load_triggers 
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
    
    private
    def setup(options={})
      if application_context = options[:application_context]
        ENV['RAILS_ENV'] = options[:env] || "development"
        
        application_path = File.join(application_context, 'config', 'environment')
        STDOUT.puts "Loading application environment at #{File.join(application_context, 'config', 'environment')} for '#{ENV['RAILS_ENV']}' enviroment."
        require(application_path)              
      end
      
      require "chrono_trigger"
    end
  end    
end