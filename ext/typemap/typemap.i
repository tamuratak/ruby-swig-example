%module "mylib::typemap"

%include std_vector.i

%{

#include "typemap.hpp"

%}

namespace T {
  class A {
  public: 
    A(int, int);
    ~A();

    //    double value<double>();
    //    int valuee();
    std::vector<A> g();
  };
};
