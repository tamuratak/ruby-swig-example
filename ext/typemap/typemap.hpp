#include <vector>
#include <string>
#include <type_traits>

namespace Typemap {
  class A {
  public:
    A(int a) : m(a) {};
    ~A();
    int get_m() { return m; }
    int m;
  };

  int gunc(std::vector<int> v) { return v[0]; }
};


