require File.join(File.dirname(__FILE__), 'process')
require "logger"
require 'optparse'
require 'yaml'

module ChronoTrigger
  class Runner

    attr_accessor :options
    private :options, :options=

    def self.run
      new
    end
    
    def self.shutdown
      @@instance.shutdown
    end

    def initialize
      @@instance = self
      parse_options

      @process = ProcessHelper.new(options[:logger], options[:pid_file], options[:user], options[:group])

      if options[:stop]
        @process.kill 
        exit(1) 
      end

      pid = @process.running?
      if pid
        if options[:force]
          STDOUT.puts "Shutting down existing ChronoTrigger."
          @process.kill
          @process = ProcessHelper.new(options[:logger], options[:pid_file], options[:user], options[:group])
        else
          STDERR.puts "There is already a ChronoTrigger process running (pid #{pid}), exiting."
          exit(1)
        end
      elsif pid.nil?
        STDERR.puts "Cleaning up stale pidfile at #{options[:pid_file]}."
      end

      start
    end

    def parse_options
      self.options =  { 
                       :log_level => Logger::INFO,
                       :daemonize => false,
                       :pid_file => File.join('', 'var', 'run', 'chrono_trigger.pid'),
                       :env => "development"
                      }

      OptionParser.new do |opts|
        opts.summary_width = 25

        opts.banner = "ChronoTrigger - Execute cron jobs within the context of a Rails application\n\n",
                      "usage: chrono_trigger [options...]\n",
                      "       chrono_trigger --help\n",
                      "       chrono_trigger --version\n"

        opts.separator ""
        opts.separator ""; opts.separator "ChronoTrigger Options:"
        
        opts.on("-tTRIGGER_FILES", "--triggers TRIGGER_FILES", "Path to file(s) specifying triggers to be executed.  Multiple files should be separated by a :.  When also specifying -a, this path will be relative to the application path") do |trigger_files|
          options[:trigger_files] = trigger_files
        end
        
        opts.on("-f", "--force", "Force restart of ChronoTrigger process (can be used in conjunction with -P).") do
          options[:force] = true
        end
        
        opts.on("-s", "--stop", "Stop a currently running ChronoTrigger process (can be used in conjunction with -P).") do
          options[:stop] = true
        end
        
        opts.separator ""
        opts.separator ""; opts.separator "Rails options:"
        
        opts.on("-aAPPLICATION", "--application RAILS", "Path to Rails application context to execture triggers in.") do |application_context|
          options[:application_context]  = application_context
        end
        
        opts.on("-eENVIRONMENT", "--environment ENVIRONMENT", "Rails environment to execute triggers in.") do |environment|
          options[:env] = environment
        end
        
        opts.separator ""
        opts.separator ""; opts.separator "Process:"

        opts.on("-PFILE", "--pid FILENAME", "save PID in FILENAME when using -d option.", "(default: #{options[:pid_file]})") do |pid_file|
          options[:pid_file] = File.expand_path(pid_file)
        end

        opts.on("-u", "--user USER", "User to run as") do |user|
          options[:user] = user.to_i == 0 ? Etc.getpwnam(user).uid : user.to_i
        end

        opts.on("-gGROUP", "--group GROUP", "Group to run as") do |group|
          options[:group] = group.to_i == 0 ? Etc.getgrnam(group).gid : group.to_i
        end

        opts.separator ""; opts.separator "Logging:"

        opts.on("-L", "--log [FILE]", "Path to print debugging information.") do |log_path|
          options[:logger] = File.expand_path(log_path)
        end

        opts.on("-v", "Increase logging verbosity (may be used multiple times).") do
          options[:log_level] -= 1
        end

        opts.on("-d", "Run as a daemon.") do
          options[:daemonize] = true
        end
      end.parse!
    end

    def start
      drop_privileges

      @process.daemonize if options[:daemonize]

      if application_context = options[:application_context]
        Dir.chdir(application_context)
      end
      
      setup_signal_traps
      @process.write_pid_file

      STDOUT.puts "Starting ChronoTrigger."
      @chrono_trigger_process = ChronoTrigger::Process.new
      @chrono_trigger_process.run(options)

      @process.remove_pid_file
    end

    def drop_privileges
      ::Process.egid = options[:group] if options[:group]
      ::Process.euid = options[:user] if options[:user]
    end

    def shutdown
      begin
        STDOUT.puts "Shutting down."
        @chrono_trigger_process.stop
        exit(1)
      rescue Object => e
        STDERR.puts "There was an error shutting down: #{e}"
        exit(70)
      end
    end

    def setup_signal_traps
      Signal.trap("INT") { shutdown }
      Signal.trap("TERM") { shutdown }
    end
  end

  class ProcessHelper

    def initialize(log_file = nil, pid_file = nil, user = nil, group = nil)
      @log_file = log_file
      @pid_file = pid_file
      @user = user
      @group = group
    end

    def safefork
      begin
        if pid = fork
          return pid
        end
      rescue Errno::EWOULDBLOCK
        sleep 5
        retry
      end
    end

    def daemonize
      sess_id = detach_from_terminal
      exit if pid = safefork

      Dir.chdir("/")
      File.umask 0000

      close_io_handles
      redirect_io

      return sess_id
    end

    def detach_from_terminal
      srand
      safefork and exit

      unless sess_id = ::Process.setsid
        raise "Couldn't detach from controlling terminal."
      end

      trap 'SIGHUP', 'IGNORE'

      sess_id
    end

    def close_io_handles
      ObjectSpace.each_object(IO) do |io|
        unless [STDIN, STDOUT, STDERR].include?(io)
          begin
            io.close unless io.closed?
          rescue Exception
          end
        end
      end
    end

    def redirect_io
      begin; STDIN.reopen('/dev/null'); rescue Exception; end

      if @log_file
        begin
          STDOUT.reopen(@log_file, "a")
          STDOUT.sync = true
        rescue Exception
          begin; STDOUT.reopen('/dev/null'); rescue Exception; end
        end
      else
        begin; STDOUT.reopen('/dev/null'); rescue Exception; end
      end

      begin; STDERR.reopen(STDOUT); rescue Exception; end
      STDERR.sync = true
    end

    def rescue_exception
      begin
        yield
      rescue Exception
      end
    end

    def write_pid_file
      return unless @pid_file
      FileUtils.mkdir_p(File.dirname(@pid_file))
      File.open(@pid_file, "w") { |f| f.write(::Process.pid) }
      File.chmod(0644, @pid_file)
    end

    def remove_pid_file
      return unless @pid_file
      File.unlink(@pid_file) if File.exists?(@pid_file)
    end

    def running?
      return false unless @pid_file

      pid = File.read(@pid_file).chomp.to_i rescue nil
      pid = nil if pid == 0
      return false unless pid

      begin
        ::Process.kill(0, pid)
        return pid
      rescue Errno::ESRCH
        return nil
      rescue Errno::EPERM
        return pid
      end
    end
    
    def kill
      return false unless @pid_file

      pid = File.read(@pid_file).chomp.to_i rescue nil
      pid = nil if pid == 0
      return false unless pid

      begin
        ::Process.kill("TERM", pid)
        remove_pid_file
        return pid
      rescue Errno::ESRCH
        return nil
      rescue Errno::EPERM
        return pid
      end
      
    end
  end
end
