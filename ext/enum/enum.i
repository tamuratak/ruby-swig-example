%module "mylib::enum"

%include std_vector.i
%include std_map.i
%include std_pair.i

%{

#include "enum.hpp"

  namespace mylib {
    namespace util {
      template <typename T>
      std::vector< T > iv_to_ev(const std::vector< int >& v){
        std::vector< T > ret(v.size());
        for(int i=0; i < v.size(); ++i) {
          ret[i] = static_cast< T >(v[i]);
        }
        return ret;
      }
    };
  };

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
    static std::vector< K::Enm > K::f_enum_v2(const std::vector< int >& v){
      using mylib::util::iv_to_ev;
      return iv_to_ev< K::Enm >(v);
    }
  }
};
