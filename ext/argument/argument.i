%module "mylib::argument"

%{

#include "argument.hpp"

%}

namespace Argument {
  class A {
  public:
    A(int);
    ~A();
  };

  void func(int);
};
