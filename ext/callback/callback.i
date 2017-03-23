%module(directors="1") "mylib::callback"

%include std_vector.i

%template(StdVectorDouble) std::vector<double>;


%{

#include "callback.hpp"

class Base {
public:
  Base() : m(1) {};
  virtual ~Base() {};
  virtual int ret_m() { return m; };
private:
  int m;
};

int get_m(Base *b) {
  return b->ret_m();
}

%}

namespace callback {  
  std::vector<double> call_block(std::vector<double>);
  void call_no_raise();
  double bar();
};

%feature("director") Base;

class Base {
public:
  Base();
  virtual ~Base();
  virtual int ret_m();
};

int get_m(Base *b);
