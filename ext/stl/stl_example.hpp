#include <vector>
#include <string>


namespace stl_e{
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

const A& ret_ref_a( const class A& a ) {
  return a;
}

const A& ret_ref_a2( const class A* a ) {
  return *a;
}

const A* ret_ptr_a( const class A* a ) {
  return a;
}


const A& first_ref_a( const std::vector< A* >& v){
  return *v[0];
}

const A* first_ptr_a( const std::vector< A* >& v){
  return v[0];
}

const A& vec_first_a( const std::vector< A >& v){
  return v[0];
}



};
