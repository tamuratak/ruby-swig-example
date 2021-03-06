%module "mylib::mod_std_function"

%include <std_common.i>
%include <std_vector.i>

%exception {
  try {
    $action
  }
  catch (const funcaller_error &e) {
    rb_jump_tag(e.state);
  }
  catch (const std::runtime_error &e) {
    rb_raise(rb_eRuntimeError, "%s", e.what());
  }
}

%{
  typedef std::vector<int> VecInt;
  template<class R, class...Args> struct Functor;
%}

%fragment("hogehoge", "header", fragment="StdTraits")
{
#include <functional>
#include <stdexcept>




  class funcaller_error {
  public:
    funcaller_error(int i) : state(i) {}
    int state;
  };

  extern "C" VALUE funcaller_call_b_proc(VALUE b_proc) {
      std::function<VALUE(void)> *f = (std::function<VALUE(void)>*) b_proc;
      return (*f)();
  }

  struct Funcaller {
    static VALUE call(std::function<VALUE(void)>& b_proc) {
      int state = 0;
      VALUE res = rb_protect(funcaller_call_b_proc, (VALUE) &b_proc, &state);
      if (state) {
        throw funcaller_error(state);
      }
      return res;
    }

    template<class R>
    static R as(VALUE res) {
      try {
        return swig::as< R >(res, true);
      }
      catch (const std::invalid_argument &e) {
        std::string s = std::string( swig::traits< R >::type_name() ) + std::string(" type expected");
        throw std::runtime_error(s);
      }
    }
  };
  template<> void Funcaller::as<void>(VALUE res) {}

  extern "C" VALUE funcall_caller(VALUE);
  struct Funcall {
    Funcall(VALUE obj, ID m, std::vector<VALUE> & v) : recv(obj), mid(m), args(v) {}

    VALUE call_impl() { 
      VALUE a = rb_ary_new_from_values(args.size(), args.data());
      return rb_apply(recv, mid, a);
    }

    VALUE call() {
      int state = 0;
      VALUE res = rb_protect(funcall_caller, (VALUE) this, &state);
      if (state) {
        throw funcaller_error(state);
      }
      return res;
    }

    template<class R>
    static R as(VALUE res) {
      try {
        return swig::as< R >(res, true);
      }
      catch (const std::invalid_argument &e) {
        std::string s = std::string( swig::traits< R >::type_name() ) + std::string(" type expected");
        throw std::runtime_error(s);
      }
    }

    VALUE recv;
    ID mid;
    std::vector<VALUE> args;
  };
  template<> void Funcall::as<void>(VALUE res) {}

  extern "C" VALUE funcall_caller(VALUE b_proc) {
    Funcall *f = (Funcall*) b_proc;
    return f->call_impl();
  }

  VALUE sw_rb_funcall(VALUE recv, ID mid, int n, ...) {
    std::vector<VALUE> v(n);
    va_list args;
    va_start(args, n);
    for(int i = 0; i < n; i++) {
      v[i] = va_arg(args, VALUE);
    }
    va_end(args);
    Funcall f(recv, mid, v);
    return f.call();
  }

  template<class R, class...Args>
    struct Functor : swig::GC_VALUE {
    typedef std::function<R(Args...)> function_type;

    Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}

    R operator()(const Args&... args) {
      //std::function<VALUE(void)> b_proc = [&]() { return rb_funcall(_obj, rb_intern("call"), sizeof...(Args), swig::from(args)...); };
      //VALUE res = Funcaller::call(b_proc);
      VALUE res = sw_rb_funcall(_obj, rb_intern("call"), sizeof...(Args), swig::from(args)...);
      return Funcall::as<R>(res);
    }

    function_type to_function() {
      return *this;
    }
  };

 int hunc(std::function<int(int)>& f) {
   return f(9);
 }

}

%fragment("hogehoge");

template<class R, class Arg1=void, class Arg2=void, class Arg3=void, class Arg4=void, class Arg5=void, class Arg6=void, class Arg7=void, class Arg8=void, class Arg9=void>
struct Functor : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&, const Arg5&, const Arg6&, const Arg7&, const Arg8&, const Arg9&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
  %fragment(SWIG_Traits_frag(Arg5));
  %fragment(SWIG_Traits_frag(Arg6));
  %fragment(SWIG_Traits_frag(Arg7));
  %fragment(SWIG_Traits_frag(Arg8));
  %fragment(SWIG_Traits_frag(Arg9));
};

template<class R, class Arg1, class Arg2, class Arg3, class Arg4, class Arg5, class Arg6, class Arg7, class Arg8>
struct Functor<R, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&, const Arg5&, const Arg6&, const Arg7&, const Arg8&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
  %fragment(SWIG_Traits_frag(Arg5));
  %fragment(SWIG_Traits_frag(Arg6));
  %fragment(SWIG_Traits_frag(Arg7));
  %fragment(SWIG_Traits_frag(Arg8));
};

template<class R, class Arg1, class Arg2, class Arg3, class Arg4, class Arg5, class Arg6, class Arg7>
struct Functor<R, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&, const Arg5&, const Arg6&, const Arg7&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
  %fragment(SWIG_Traits_frag(Arg5));
  %fragment(SWIG_Traits_frag(Arg6));
  %fragment(SWIG_Traits_frag(Arg7));
};

template<class R, class Arg1, class Arg2, class Arg3, class Arg4, class Arg5, class Arg6>
struct Functor<R, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&, const Arg5&, const Arg6&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
  %fragment(SWIG_Traits_frag(Arg5));
  %fragment(SWIG_Traits_frag(Arg6));
};

template<class R, class Arg1, class Arg2, class Arg3, class Arg4, class Arg5>
struct Functor<R, Arg1, Arg2, Arg3, Arg4, Arg5, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&, const Arg5&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
  %fragment(SWIG_Traits_frag(Arg5));
};

template<class R, class Arg1, class Arg2, class Arg3, class Arg4>
struct Functor<R, Arg1, Arg2, Arg3, Arg4, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&, const Arg4&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
  %fragment(SWIG_Traits_frag(Arg4));
};

template<class R, class Arg1, class Arg2, class Arg3>
struct Functor<R, Arg1, Arg2, Arg3, void, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&, const Arg3&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
  %fragment(SWIG_Traits_frag(Arg3));
};

template<class R, class Arg1, class Arg2>
struct Functor<R, Arg1, Arg2, void, void, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1&, const Arg2&);
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
};

template<class R, class Arg1 >
struct Functor<R, Arg1, void, void, void, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()(const Arg1& a1);
  std::function<R(Arg1)> to_function();
  %fragment(SWIG_Traits_frag(R));
  %fragment(SWIG_Traits_frag(Arg1));
};

template<class R, class Arg1 >
struct Functor<R, void, void, void, void, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  R operator()();
  %fragment(SWIG_Traits_frag(R));
};

template<class Arg1, class Arg2>
struct Functor<void, Arg1, Arg2, void, void, void, void, void, void, void> : swig::GC_VALUE {
  Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
  void operator()(const Arg1&, const Arg2&);
  %fragment(SWIG_Traits_frag(Arg1));
  %fragment(SWIG_Traits_frag(Arg2));
};


template<class R, class Arg>
class std::function {};

%define %call_traits_frag(Type, ...)
  %fragment(SWIG_Traits_frag(Type));
  %call_traits_frag(__VA_ARGS__);
%enddef


%define %std_function(Name, R, ...)
template<>
class std::function<R(__VA_ARGS__)> {
public:
  R operator()(__VA_ARGS__);
  //  %call_traits_frag(R, __VA_ARGS__);
  %extend{
    std::function(VALUE obj) {
      auto ret = new std::function<R(__VA_ARGS__)>();
      *ret = Functor< R , __VA_ARGS__ >(obj);
      return ret;
    }
  }
};
%template(Name) std::function<int(__VA_ARGS__)>;
%enddef

%template(VecInt) std::vector<int>;
typedef std::vector<int> VecInt;

%template(FunctorIntInt) Functor<int, int>;
%template(FunctorVoidIntDouble) Functor<void, int, double>;
%template(FunctorIntIntDouble) Functor<int, int, double>;
%template(FunctorIntVec) Functor<int, std::vector<int> >;
%template(FunctorIntInt8) Functor<int, int, int, int, int, int, int, int, int>;
%template(FunctorIntInt7) Functor<int, int, int, int, int, int, int, int>;

%std_function(FunctionIntInt, int, int);
%std_function(FunctionIntVec, int, VecInt);

int hunc(std::function<int(int)>& f);
%init %{
  std::function<int(int)> f = Functor<int, int>();
%}
