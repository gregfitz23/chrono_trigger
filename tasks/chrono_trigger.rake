namespace :chrono_trigger do
  
  run_task_name = defined?(RAILS_ROOT) ? {:run => :environment} : :run
  desc "Execute all triggers in loop, sleeping 1 minute between checks."
  task run_task_name do
    shell = ChronoTrigger::Shell.new
    shell.load_triggers
    loop do
      shell.execute_triggers
      sleep 1.minute.to_i
    end
    
  end
end