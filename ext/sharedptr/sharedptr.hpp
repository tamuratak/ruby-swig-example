#include <vector>
#include <string>
#include <iostream>
#include <memory>

namespace Klass{
class A {
public:
  A(double a) : m(a) {};
  ~A() { std::cout << "C++ level A destroyed" << std::endl; };
  double get_m(){
    return m;
  }
private:
  double m;
};

class B {
public:
  B(std::shared_ptr<A> a) : _a(a) {};

  std::shared_ptr<A> get_a(){
    return _a;
  }
private:
  std::shared_ptr<A> _a;
};

};
