%module "mylib::sharedptr"

%include std_vector.i
%include std_shared_ptr.i

%shared_ptr(Klass::A)

%{

#include "sharedptr.hpp"

%}


namespace Klass {
  class A {
  public:  
    A(double d);
    ~A();
    double get_m();
  };

  class B {
  public:
    B(std::shared_ptr<A>);
    ~B();
    std::shared_ptr<A> get_a();
  };
};
