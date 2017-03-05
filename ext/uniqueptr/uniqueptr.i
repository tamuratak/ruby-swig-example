%module "mylib::uniqueptr"

%include std_vector.i

%{
#include "uniqueptr.hpp"
%}


namespace std {
  %feature("novaluewrapper") unique_ptr;
  %nodefaultctor;
  template <typename Type>
  struct unique_ptr {
    Type* operator-> () const;
    ~unique_ptr();
  };
}

%define wrap_unique_ptr(Name, Type)
  %template(Name) std::unique_ptr<Type>;
  %typemap(out) std::unique_ptr<Type> %{
    $result = SWIG_NewPointerObj(new $1_ltype(std::move($1)), $&1_descriptor, SWIG_POINTER_OWN);
  %}
%enddef

wrap_unique_ptr(StdUniquePtrA, A)

%extend std::unique_ptr<A> {
  %newobject create;
  static std::unique_ptr<A>* create(int i){ 
    return new std::unique_ptr<A>(new A(i)); 
  }
  static std::unique_ptr<A>* create(const A& a){ 
    return new std::unique_ptr<A>(new A(a)); 
  }
}

%template(StdVectorStdUniquePtrA) std::vector<std::unique_ptr<A>* >;

%include "uniqueptr.hpp"
