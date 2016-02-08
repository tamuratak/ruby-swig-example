require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

elibs =
[
#"stl", 
#"cpp11", 
#"enum", 
"typemap"]

elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.lib_dir = "lib/mylib"
  end
}

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :swig do  
  elibs.each{|f|
    sh "swig -c++ -ruby -Wall ext/#{f}/#{f}.i"
  }
end

desc "Run tests"
task :default => [:test]
task :build => [:swig, :compile]
