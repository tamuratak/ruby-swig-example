#include <vector>
#include <string>

typedef int mylib_t;
typedef std::vector< int > StdVectorInt;

int fv(const mylib_t v){
  return v;
}

StdVectorInt fvec(const StdVectorInt& v){
  return v;
}
