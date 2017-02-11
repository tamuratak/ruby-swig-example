require 'mkmf'
have_library("c++") or have_library("stdc++")

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++11 -O2 -Wall "
create_makefile('mylib/typemap')
