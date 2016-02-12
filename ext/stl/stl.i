%module "mylib::stl"

%include std_vector.i
%include std_string.i
%include std_map.i
%include std_pair.i

%{

#include "stl_example.hpp"

namespace stl_e {

  template<class T>
  std::vector<T*> vec_to_pvec(std::vector<T>& v){
    std::vector<T*> ret(v.size());
    for(int i = 0; i < v.size(); i++){
      ret[i] = &(v[i]);
    }
    return ret;
  }

};

%}

%template() std::vector<std::string>;
%template() std::vector< std::vector<std::string> >;
%template() std::map< std::string, std::string >;


namespace stl_e {

int vec_len(const std::vector<std::string>& s);
std::string get_hash_x(const std::map< std::string, std::string >& h);
std::string first_string(const std::vector< std::vector<std::string> >& v);

class A {
public:
  unsigned long int get_address();
};

%template(StdVectorAptr) ::std::vector<stl_e::A*>;
%template() ::std::vector<stl_e::A>;

stl_e::A ret_a(const stl_e::A&);
stl_e::A& ret_ref_a(const stl_e::A&);
stl_e::A& ret_ref_a2(const stl_e::A*);
stl_e::A* ret_ptr_a(const stl_e::A*);
stl_e::A& first_ref_a(const ::std::vector<stl_e::A*>&);
stl_e::A* first_ptr_a(const ::std::vector<stl_e::A*>&);

const stl_e::A& get_a_from_vec( const std::vector<stl_e::A>& v, int n);
%newobject CreateVec;
std::vector<stl_e::A>& CreateVec(int n);

  std::vector<stl_e::A*> vec_to_pvec(std::vector<stl_e::A>& v);

};
