require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'

elibs = ["callback", "cpp11", "enum", "stl", "template", "typemap"]

elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.lib_dir = "lib/mylib"
  end
}

namespace :swg do
  elibs.each{|f|
    task f do
      sh "swig -c++ -ruby -Wall ext/#{f}/#{f}.i"
    end
  }
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end
desc "Run tests"

task :swig => elibs.map{|f| "swg:#{f}" }
task :default => [:test]
task :build => [:swig, :compile]

# rake compile:stl
