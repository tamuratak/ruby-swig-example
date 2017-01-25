%module "mylib::unorderedmap"

%include <std_unordered_map.i>
%include <std_map.i>

%{

#include "unorderedmap.hpp"

%}

%template(StdUMapIntInt) std::unordered_map<int, int>;
%template(StdMapIntInt) std::map<int, int>;

namespace Klass {
  class A {
  public:  
    A(const std::unordered_map<int, int>& h);
    ~A();
    std::unordered_map<int, int> get_m();
  };

  class B {
  public:
    B(const std::map<int, int>&);
    ~B();
    std::map<int, int> get_m();
  };
};
