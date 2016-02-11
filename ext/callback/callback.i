%module "mylib::callback"

%include std_vector.i

%template(StdVectorDouble) std::vector<double>;


%{

#include "callback.hpp"

%}

namespace callback {  
  std::vector<double> foo();
  double bar();
};
