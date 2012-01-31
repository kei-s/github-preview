require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  ENV['RACK_ENV'] = 'test'
  t.pattern = "spec/**/*_spec.rb"
end
