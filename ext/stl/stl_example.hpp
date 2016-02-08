#include <vector>
#include <string>

int vec_len(const std::vector<std::string> s) {
  return s.size();
}

std::string get_hash_x(const std::map< std::string, std::string >& h) {
  const std::map< std::string, std::string >::const_iterator it = h.find("x");
  if (it != h.end()) 
    return it->second;  
  return "";
}

std::string first_string(const std::vector< std::vector<std::string> >& v) {
  return v[0][0];
}

/*
static void from_myclassvec(const std::vector< MyClass >& v) {
  std::cout << v[0].get() << std::endl;
}
*/

class A {
public:
  unsigned long int get_address(){
    return reinterpret_cast<unsigned long int>(this);
  }
};

class A ret_a( const class A& a ) {
  return a;
}

const class A& ret_ref_a( const class A& a ) {
  return a;
}
