%module "mylib::template"

%include std_vector.i
%include std_string.i
%include std_map.i
%include std_pair.i

%{

#include "template.hpp"

%}

namespace tpl {
  template <class T>
  class A {
  public:
    A(const T&);
  };
  //  typedef A<int> AInt;
  %template(AInt) A<int>;
};
