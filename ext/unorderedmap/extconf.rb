require 'mkmf'
have_library("c++") or have_library("stdc++")

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 -O2 -Wall -D__STDC_WANT_LIB_EXT1__ "
create_makefile('mylib/unorderedmap')
