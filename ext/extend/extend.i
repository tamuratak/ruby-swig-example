%module "mylib::extend"

%include std_vector.i

%{

#include "extend.hpp"

%}


namespace Klass {
  class A {
  public:  
%extend {
    A(double d) {
      std::cout << "extended" << std::endl;
      return new Klass::A(d);
    }
}
    ~A();
    double get_m();
  };
};
