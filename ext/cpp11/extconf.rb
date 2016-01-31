require 'mkmf'
have_library("c++") or have_library("stdc++")

$CXXFLAGS = ($CXXFLAGS || "") + " -std=c++0x -O2 -Wall "
create_makefile('mylib/cpp11')
