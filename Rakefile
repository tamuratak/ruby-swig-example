require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

Rake::ExtensionTask.new "stl" do |ext|
  ext.lib_dir = "lib/mylib"
end

Rake::ExtensionTask.new "cpp11" do |ext|
  ext.lib_dir = "lib/mylib"
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test

