#include <vector>

class A {
public:
  unsigned long int get_address(){
    return reinterpret_cast<unsigned long int>(this);
  }
};

class A return_a( const class A& a ) {
  return a;
}

A& return_ref_a( class A& a ) {
  return a;
}

A* return_ptr_a( class A* a ) {
  return a;
}

const A& return_const_ref_a( const class A& a ) {
  return a;
}

const A& return_ref_a2( const class A* a ) {
  return *a;
}

const A* return_const_ptr_a( const class A* a ) {
  return a;
}

std::vector<A> return_vec_a( const A& a ) {
  std::vector<A> v;
  v.push_back(a);
  return v;
}

std::vector<A>& return_ref_vec_a( const A& a ) {
  std::vector<A> *v = new std::vector<A>();
  v->push_back(a);
  return *v;
}

std::vector<A>* return_ptr_vec_a( const A& a ) {
  std::vector<A> *v = new std::vector<A>();
  v->push_back(a);
  return v;
}

const std::vector<A> return_const_vec_a( const A& a ) {
  std::vector<A> v;
  v.push_back(a);
  return v;
}
