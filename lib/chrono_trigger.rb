$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module ChronoTrigger
  VERSION = '0.0.1'
end

require "activesupport"
require "chrono_trigger/shell"
require "chrono_trigger/trigger"
require "chrono_trigger/date_list"