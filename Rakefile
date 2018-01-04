require 'bundler/gem_tasks'
require 'reek/rake/task'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

Reek::Rake::Task.new
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: %i[spec rubocop reek]
