%module "mylib::stl"

%include std_vector.i
%include std_string.i
%include std_map.i
%include std_pair.i

%{

#include "stl_example.hpp"

%}

%template(StdVecString) std::vector<std::string>;
%template(StdVecVecString) std::vector< std::vector<std::string> >;
%template(MapStringString) std::map< std::string, std::string >;

int vec_len(const std::vector<std::string>& s);
std::string get_hash_x(const std::map< std::string, std::string >& h);
std::string first_string(const std::vector< std::vector<std::string> >& v);


