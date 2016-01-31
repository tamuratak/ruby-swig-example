Gem::Specification.new do |s|
  s.name        = 'mylib'
  s.version     = '0.0.1'
  s.date        = '2016-01-31'
  s.summary     = "Examples of writing ruby bindings for C/C++ library using SWIG."
  s.description = "Examples of writing ruby bindings for C/C++ library using SWIG."
  s.authors     = ["Takashi Tamura"]
  s.email       = ''
  s.files       = ["LICENSE",
                   "lib/mylib.rb"] + Dir.glob("ext/*/*.cxx") + Dir.glob("ext/*/extconf.rb")
  s.extensions  = Dir.glob("ext/*/extconf.rb")
  s.homepage    = 'https://github.com/tamuratak/ruby-swig-example'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rake-compiler', '~> 0.9.5'
  s.rdoc_options << "--exclude=."
  s.required_ruby_version = '>= 2.2.0'
end
