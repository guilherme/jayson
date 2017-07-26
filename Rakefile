require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("jayson") do |ext|
  ext.lib_dir = "lib/jayson"
end

desc 'Benchmark Jayson against JSON'
task :benchmark => [:clobber, :compile] do
  require 'json'
  require 'benchmark'
  require 'jayson'

  Benchmark.bm do |m| 
    m.report("Jayson") do
      1_000.times { Jayson.parse(%({"a":"b"})) }
    end
    m.report("JSON") do
      1_000.times { JSON.parse(%({"a":"b"})) }
    end
  end
end

task :default => [:clobber, :compile, :spec]
