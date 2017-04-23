require 'mkmf'
have_library("c++") or have_library("stdc++")

$CXXFLAGS = ($CXXFLAGS || "") + " -O2 -Wall -std=c++11 "
create_makefile('mylib/mod_std_function')
