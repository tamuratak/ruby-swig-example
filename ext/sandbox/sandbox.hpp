#include <string>
#include <iostream>
#include <functional>
#include <unordered_map>
#include <map>

namespace Sandbox{

  class A {
public:
    A( int a) : m(a) {};
    ~A() {};
    int get_m() const {
      return m;
    }
private:
    int m;
};
  
  int func(const A& a) {
    std::cout <<  a.get_m() << std::endl;
    return a.get_m();
  }

  int gunc(std::vector<int>& v) {
    std::cout <<  v[0] << std::endl;
    return v[0];
  }
};
