%module "mylib::enum"

%include std_vector.i
%include std_map.i
%include std_pair.i

%{

#include "enum.hpp"

%}

typedef std::vector< enum K::Enm > StdVectorEnm;
typedef std::vector< int > StdVectorInt;
%template(StdVectorEnm) std::vector< enum K::Enm >;
%template(StdVectorInt) std::vector< int >;

class K {
public:
  enum Enm {A, B};  
  static enum Enm f_enum(const enum Enm);
  %extend {
    static std::vector< K::Enm > K::f_enum_v(const std::vector< int >& v){
      std::vector< enum K::Enm > ret(v.size());
      for(int i=0; i < v.size(); ++i) {
        ret[i] = static_cast<K::Enm>(v[i]);
      }
      return ret;
    }
  }
};
