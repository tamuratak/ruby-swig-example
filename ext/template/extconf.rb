require 'mkmf'
have_library("c++") or have_library("stdc++")

$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -Wall "
create_makefile('mylib/template')
