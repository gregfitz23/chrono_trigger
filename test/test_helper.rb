require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/chrono_trigger'
require "shoulda"
require "mocha"


def quietly
  old_stderr = $stderr
  STDERR.reopen("/dev/null", 'w')
  yield
  $stderr = old_stderr
end