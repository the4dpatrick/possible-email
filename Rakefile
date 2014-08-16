#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color', '--format', 'nested']
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

task :default => :spec
