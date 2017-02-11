%module "mylib::sandbox"

%include std_vector.i

%{

#include "sandbox.hpp"

%}

%template(StdVectorInt) std::vector<int>;


%typemap(in) Sandbox::A x {
  
}

namespace Sandbox {
  int func(Sandbox::A x);
  int gunc(std::vector<int>);
};

