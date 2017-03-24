%module(directors="1") "mylib::callback"

%{

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

%feature("director") Base;

class Base {
public:
  Base();
  virtual ~Base();
  virtual int ret_m();
};

int get_m(Base *b);
