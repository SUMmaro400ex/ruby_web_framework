require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
sh "./bin/console"
end

task :start do
  require "kwypper"
  Kwypper.run
end
