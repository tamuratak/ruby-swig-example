%module "mylib::typemap"

%include std_vector.i

%{

#include "typemap.hpp"

%}

%template() std::vector<int>;

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

%typemap(in) std::vector<Typemap::A> (std::vector<Typemap::A> tmp) {
  VALUE arry = rb_check_array_type($input);
  if (NIL_P(arry)) {
    rb_raise(rb_eArgError, "Array expected"); SWIG_fail;
  }else{
    $1 = std::vector<Typemap::A>(RARRAY_LEN(arry));
    for (int i=0; i<RARRAY_LEN(arry); i++) {
        VALUE elt = RARRAY_AREF(arry, i);
        Typemap::A aptr;
        int res = swig::asval((VALUE)elt, &aptr);
        if (!SWIG_IsOK(res)){
          delete &$1;
          rb_raise(rb_eArgError, "Array of Typemap::A expected");
          SWIG_fail;
        }
        (*(&$1))[i] = aptr;
    }
  }
}

%typemap(in) Typemap::A {
  Typemap::A *aptr;
  int res = SWIG_ConvertPtr($input, (void **) &aptr, SWIG_TypeQuery("Typemap::A"),  0 ); // SWIGTYPE_p_Typemap__A
  if (!SWIG_IsOK(res)){
    rb_raise(rb_eArgError, "Typemap::A expected");
  }
  if (!aptr){
    rb_raise(rb_eArgError, "Typemap::A expected");
  }
  $1 = *aptr;
}


%typemap(in) Typemap::B {
  Typemap::B bptr;
  int res = swig::asval((VALUE) $input, &bptr);
  if (!SWIG_IsOK(res)){
    rb_raise(rb_eArgError, "Typemap::B expected"); // bptr would not be properly deleted. 
    SWIG_fail;
  }
  $1 = bptr;
}

%{

namespace swig {

  template <> struct traits< ::Typemap::A > {
    typedef value_category category;
    static const char* type_name() { return "Typemap::A"; }
  };

  template <> struct traits< ::Typemap::B > {
    typedef value_category category;
    static const char* type_name() { return "Typemap::B"; }
  };

};

%}

namespace Typemap {
  class A {
  public:
    A();
    A(int);
    ~A();
  };

  class B {
  public:
    B();
    B(int);
    ~B();
  };
  int gunc(std::vector<int>);
  int hunc(std::vector<A>);
  int junc(A);
  int iunc(B);
};
