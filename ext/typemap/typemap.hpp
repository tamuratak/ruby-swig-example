#include <vector>
#include <string>
#include <type_traits>

typedef int mylib_t;
typedef std::vector< int > StdVectorInt;

int fv(const mylib_t v){
  return v;
}

StdVectorInt fvec(const StdVectorInt& v){
  return v;
}

namespace T {
  class A {
  public:
    A(int n, int m) : nnn(n), mmm(m), v{} {};
    ~A();

    
    template<typename T, typename std::enable_if<std::is_same<T, int>::value>::type* = nullptr>
    T valuee() { return this->nnn; }
  
  //    void f(){ int i = valuee(); };
  std::vector<A> g(){ return v; };
  int nnn;
  int mmm;
  double d;
  std::vector<A> v;
};

};


