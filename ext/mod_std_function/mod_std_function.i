%module "mylib::mod_std_function"

%include <std_common.i>
%include <std_vector.i>

%template() std::vector<int>;

%exception {
  try {
    $action
  }
  catch (const std::exception &e) {
    rb_raise(rb_eRuntimeError, "%s", e.what());
  }
}

%wrapper %{
#include <functional>
#include <type_traits>
#include <stdexcept>

  template<class R, class Arg1 >
  struct Functor : swig::GC_VALUE {
    Functor(VALUE obj = Qnil) : GC_VALUE(obj), is_raised(false) {}
    R operator()(Arg1 a1) {
      VALUE arg1 = swig::from(a1);
      std::function<VALUE(void)> b_proc = [=]() { return rb_funcall(_obj, rb_intern("call"), 1, arg1); };
      VALUE res = rb_rescue2(RUBY_METHOD_FUNC(call_b_proc), (VALUE) &b_proc,
                             RUBY_METHOD_FUNC(r_proc), (VALUE) &is_raised,
                             rb_eException, 0);
      if (is_raised) {
        VALUE backtrace = rb_funcall(res, rb_intern("backtrace"), 0);
        VALUE m = rb_funcall(backtrace, rb_intern("join"), 1, rb_str_new2("\n\t\t"));
        is_raised = false;
        throw std::runtime_error(StringValueCStr(m));
      }
      return swig::as< R >(res);
    }

    static VALUE r_proc(VALUE data, VALUE exc) {
      bool *is_raised_ = (bool *) data;
      *is_raised_ = true;
      return exc;
    }

    static VALUE call_b_proc(VALUE f) {
      std::function<VALUE(void)> *f_ = (std::function<VALUE(void)>*) f;
      return (*f_)();
    };

    bool is_raised;
  };
  
%}

  template<class R, class Arg1 >
  struct Functor : swig::GC_VALUE {
    Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
    R operator()(Arg1 a1);
    %fragment(SWIG_Traits_frag(R));
    %fragment(SWIG_Traits_frag(Arg1));
  };

%template(FunctorIntInt) Functor<int, int >;
%template(FunctorIntVec) Functor<int, std::vector<int> >;

%init %{
  std::function<int(int)> f = Functor<int, int>();
%}
