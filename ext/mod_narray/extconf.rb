require 'mkmf'
have_library("c++") or have_library("stdc++")

gems = Gem::Specification.find_all_by_name("numo-narray")
if gems.size > 1
  raise "multiple numo-narray gems found"
end
find_header("numo/narray.h", File.join(gems[0].gem_dir, "lib/numo/") )
$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -Wall -std=c++11 -D__STDC_WANT_LIB_EXT1__ "

create_makefile('mylib/mod_narray')
