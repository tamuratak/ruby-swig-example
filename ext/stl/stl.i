%module "mylib::stl"

%include std_vector.i
%include std_string.i
%include std_map.i
%include std_pair.i

%{

#include "stl_example.hpp"

%}

%template() std::vector<std::string>;
%template() std::vector< std::vector<std::string> >;
%template() std::map< std::string, std::string >;

int vec_len(const std::vector<std::string>& s);
std::string get_hash_x(const std::map< std::string, std::string >& h);
std::string first_string(const std::vector< std::vector<std::string> >& v);

class A {
public:
  unsigned long int get_address();
};

%template() std::vector< A* >;

A ret_a(const A&);
A& ret_ref_a(const A&);
A& ret_ref_a2(const A*);
A* ret_ptr_a(const A*);
A& first_ref_a(const std::vector< A* >&);
A* first_ptr_a(const std::vector< A* >&);
