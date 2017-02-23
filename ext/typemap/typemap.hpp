#include <vector>

namespace Typemap {
  class A {
  public:
    A() : m(0) {};
    A(int a) : m(a) {};
    int get_m() { return m; }
    int m;
  };

  class B {
  public:
    B() : m(0) {};
    B(int a) : m(a) {};
    int get_m() { return m; }
    int m;
  };

  class C {
  public:
    C() : m(0) {};
    C(int a) : m(a) {};
    int get_m() { return m; }
    int m;
  };

  int gunc(std::vector<int> v) { return v[0]; }
  int hunc(std::vector<A> v) {
    return v[0].get_m();
  }

  int iunc(A b) {
    return b.get_m();
  }

  int junc(B a) {
    return a.get_m();
  }

  int kunc(C c) {
    return c.get_m();
  }

};


