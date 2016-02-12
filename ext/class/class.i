%module "mylib::class"

%include std_vector.i

%{

#include "class.hpp"

%}


namespace Klass {
  class A {
  public:  
    A(double);
    ~A();
    double get_m();

    %newobject Create;
    %extend{
      static Klass::A* Create(double a, double b){
        Klass::A* p = new Klass::A(a);
        return p;
      }
    }
  };
};
