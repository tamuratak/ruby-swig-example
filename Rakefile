require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

[
#"stl", 
#"cpp11", 
#"enum", 
"typemap"].each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.lib_dir = "lib/mylib"
  end
}

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :swig do  
  Dir::glob("ext/*/*.i"){|f|
    sh "swig -c++ -ruby -Wall #{f}"
  }
end

desc "Run tests"
task :default => [:test]
task :build => [:swig, :compile]
