# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{chrono_trigger}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Greg Fitzgerald"]
  s.date = %q{2009-04-02}
  s.description = %q{A cron framework for defining cron tasks using a readable DSL.}
  s.email = ["fitzgerald@healthcentral.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/chrono_trigger.rb", "lib/chrono_trigger/cron_entry.rb", "lib/chrono_trigger/shell.rb", "lib/chrono_trigger/trigger.rb", "lib/triggers/test_triggers.rb", "script/console", "script/destroy", "script/generate", "tasks/chrono_trigger.rake", "test/test_chrono_trigger.rb", "test/test_cron_entry.rb", "test/test_helper.rb", "test/test_shell.rb", "test/test_trigger.rb", "test/triggers.rb"]
  s.has_rdoc = true
  s.homepage = %q{FIX (url)}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gregfitz23-chrono_trigger}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A cron framework for defining cron tasks using a readable DSL.}
  s.test_files = ["test/test_chrono_trigger.rb", "test/test_cron_entry.rb", "test/test_helper.rb", "test/test_shell.rb", "test/test_trigger.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.1"])
      s.add_development_dependency(%q<thoughtbot_shoulda>, [">= 2.0.6"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_dependency(%q<newgem>, [">= 1.2.1"])
      s.add_dependency(%q<thoughtbot_shoulda>, [">= 2.0.6"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    s.add_dependency(%q<newgem>, [">= 1.2.1"])
    s.add_dependency(%q<thoughtbot_shoulda>, [">= 2.0.6"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
