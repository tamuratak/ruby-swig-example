%module "mylib::typemap"

 // %include std_vector.i

%{

#include "typemap.hpp"

%}

%typemap(in) std::vector<int> {
  VALUE arry = rb_check_array_type($input);
  if(NIL_P(arry)) {
    rb_raise(rb_eArgError, "Array expected"); SWIG_fail;
  }else{
    $1.resize(RARRAY_LEN(arry));
    for (int i=0; i<RARRAY_LEN(arry); i++) {
	VALUE elt = RARRAY_AREF(arry, i);
        $1[i] = NUM2INT(elt);
    }
  }
}

namespace Typemap {
  int gunc(std::vector<int>);
};
