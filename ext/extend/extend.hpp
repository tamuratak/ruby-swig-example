#include <vector>
#include <string>
#include <iostream>

namespace Klass{
class A {
public:
  A(double a) : m(a) {};
  double get_m(){
    return m;
  }
private:
  double m;
};
};
