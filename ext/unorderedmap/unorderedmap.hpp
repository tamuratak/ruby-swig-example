#include <string>
#include <iostream>
#include <functional>
#include <unordered_map>
#include <map>

namespace Klass{
class A {
public:
  A( std::unordered_map<int, int> a) : m(a) {};
  ~A() {};
  std::unordered_map<int, int> get_m(){
    return m;
  }
  std::unordered_map<int, int>& get_ref_m(){
    return m;
  }

private:
   std::unordered_map<int, int> m;
};

class B {
public:
  B( std::map<int, int> b) : m(b) {};
  ~B() {};
  std::map<int, int> get_m(){
    return m;
  }
private:
  std::map<int, int> m;
};
};
