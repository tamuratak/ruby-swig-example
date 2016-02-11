#include <ruby.h>
#include <vector>
#include <string>

namespace callback {

  VALUE my_rb_proc_call(VALUE args[]){
    return rb_proc_call(args[0], args[1]);
  }
  
  std::vector<double> foo(){
    VALUE prc = rb_block_proc();
    VALUE a;
    VALUE args[2];
    args[0] = prc;
    args[1] = rb_ary_new();
    a = rb_rescue2(RUBY_METHOD_FUNC(my_rb_proc_call), (VALUE) args, 
                   0, 0, rb_eStandardError);

    std::vector< double > *x;
    if( !NIL_P(a) && SWIG_IsOK(swig::asptr(a, &x)) ){
      return *x;
    }else{
      SWIG_Error(SWIG_RuntimeError, "error error error");
    }    
  }

  double bar(){
    VALUE a = rb_ary_new_from_args(2, DBL2NUM(11.0), DBL2NUM(22.0));
    std::vector< double > *x;
    ::swig::asptr(a, &x);
    return (*x)[0];
  }

};
