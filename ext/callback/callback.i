%module "mylib::callback"

%include std_vector.i

%template(StdVectorDouble) std::vector<double>;


%{

#include "callback.hpp"

%}

namespace callback {  
  std::vector<double> call_block();
  void call_no_raise();
  double bar();
};
