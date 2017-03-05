%module "mylib::conv"

%include std_vector.i

%inline %{

#include "conv.hpp"

%}

// write %template declarations first.
%template(StdVectorA) std::vector<A>;

%include "conv.hpp"

