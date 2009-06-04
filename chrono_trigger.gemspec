# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{chrono_trigger}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Greg Fitzgerald"]
  s.date = %q{2009-06-04}
  s.default_executable = %q{chrono_trigger}
  s.description = %q{TODO}
  s.email = %q{greg_fitz@yahoo.com}
  s.executables = ["chrono_trigger"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "History.txt",
    "Manifest.txt",
    "PostInstall.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/chrono_trigger",
    "lib/chrono_trigger.rb",
    "lib/chrono_trigger/cron_entry.rb",
    "lib/chrono_trigger/process.rb",
    "lib/chrono_trigger/runner.rb",
    "lib/chrono_trigger/shell.rb",
    "lib/chrono_trigger/tasks.rb",
    "lib/chrono_trigger/trigger.rb",
    "lib/tasks/chrono_trigger.rake",
    "lib/triggers/test_triggers.rb",
    "test/test_chrono_trigger.rb",
    "test/test_cron_entry.rb",
    "test/test_helper.rb",
    "test/test_shell.rb",
    "test/test_trigger.rb",
    "test/triggers.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/test_chrono_trigger.rb",
    "test/test_cron_entry.rb",
    "test/test_helper.rb",
    "test/test_shell.rb",
    "test/test_trigger.rb",
    "test/triggers.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
