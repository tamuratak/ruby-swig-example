#include <vector>
#include <string>


class K {
public:
  enum Enm {A, B};
  
  static enum Enm f_enum(const enum Enm e) {
    return e;
  }
  
  static std::vector< enum Enm> f_enum_v(const std::vector<enum Enm>& v) {
    return v;
  }
};
