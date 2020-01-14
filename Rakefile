require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Start a console session with Fawry gem loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'resultt'

  ARGV.clear
  IRB.start
end
