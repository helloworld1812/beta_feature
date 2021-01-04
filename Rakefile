require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)

load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec