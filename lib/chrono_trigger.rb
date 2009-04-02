$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module ChronoTrigger
  VERSION = '0.0.2'
end

require "activesupport"
require "chrono_trigger/shell"
require "chrono_trigger/trigger"
require "chrono_trigger/cron_entry"
