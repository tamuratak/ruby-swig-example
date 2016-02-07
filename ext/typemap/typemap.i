%module "mylib::typemap"

%include std_vector.i
%include std_string.i
%include std_map.i
%include std_pair.i

%{

#include "typemap.hpp"

%}

%apply int { mylib_t };

int fv(mylib_t v);
