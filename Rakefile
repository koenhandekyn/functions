# require "bundler/gem_tasks"
# require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.libs << "test" << "."
#   t.test_files = FileList['test/test*.rb']
#   t.verbose = false
# end

require 'rspec/core/rake_task'

desc 'run the basic specs'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--options', 'spec/rspec.opts']
end

desc 'do some basic performance tests'
task :performance do
  load 'performance/prelude_performance.rb'
end

task default: [:spec, :performance]