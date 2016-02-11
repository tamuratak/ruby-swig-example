#include <vector>
#include <string>


namespace Klass{
class A {
public:
  A(double a) : m(a) {}
  double get_m(){
    return m;
  }
private:
  double m;
};
};
