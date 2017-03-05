#include <vector>
#include <string>
#include <iostream>
#include <memory>

class A {
public:
  A(int a) : m(a) {};
  ~A() { std::cout << "C++ level A destroyed" << std::endl; };
  int get_m(){
    return m;
  }
private:
  int m;
};


std::unique_ptr<A> return_unique_ptr(int i) {
  return std::unique_ptr<A>(new A(i));
}
