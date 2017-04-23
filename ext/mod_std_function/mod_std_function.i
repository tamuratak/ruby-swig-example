%module "mylib::mod_std_function"

%include <std_common.i>
%include <std_vector.i>

%template() std::vector<int>;

%wrapper %{
#include <functional>

  template<class R, class Arg1 >
  struct Functor : swig::GC_VALUE {
    Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
    R operator()(Arg1 a1) const {
      VALUE arg1 = swig::from(a1);
      VALUE res = rb_funcall( _obj, rb_intern("call"), 1, arg1);
      return swig::as< R >(res);
    }
  };
  
%}

  template<class R, class Arg1 >
  struct Functor : swig::GC_VALUE {
    Functor(VALUE obj = Qnil) : GC_VALUE(obj) {}
    R operator()(Arg1 a1) const;
    %fragment(SWIG_Traits_frag(R));
    %fragment(SWIG_Traits_frag(Arg1));
  };

%template(FunctorIntInt) Functor<int, int >;
%template(FunctorIntVec) Functor<int, std::vector<int> >;

%init %{
  std::function<int(int)> f = Functor<int, int>();
%}
