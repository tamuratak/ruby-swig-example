%module "mylib::typemap"

%include std_vector.i

%{

#include "typemap.hpp"

%}

%template(StdVectorInt) std::vector< int >;
typedef std::vector< int > StdVectorInt;
// typedef int mylib_t;
%apply int { mylib_t };


int fv(const mylib_t v);
StdVectorInt fvec(const StdVectorInt& v);
