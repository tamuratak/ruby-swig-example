#include <string>
#include <iostream>
#include <functional>
#include <unordered_map>

namespace Klass{
class A {
public:
  A( std::unordered_map<int, int> a) : m(a) {};
  ~A() {};
  std::unordered_map<int, int> get_m(){
    return m;
  }
private:
   std::unordered_map<int, int> m;
};

};
