%module "mylib::unorderedmap"

%include "std_unordered_map.i"

%{

#include "unorderedmap.hpp"

%}

%template(StdMapIntInt) std::unordered_map<int, int>;

namespace Klass {
  class A {
  public:  
    A(const std::unordered_map<int, int>& h);
    ~A();
    std::unordered_map<int, int> get_m();
  };
};
