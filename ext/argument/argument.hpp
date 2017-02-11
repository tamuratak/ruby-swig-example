#include <string>
#include <iostream>


namespace Argument {
  class A {
  public:
    A(const int& i) : m(i) {}
    int get_m() const { return m; }
    int m;
  };
  
  void func(int a){
    //    std::cout << a.get_m() << std::endl;
  }
};
