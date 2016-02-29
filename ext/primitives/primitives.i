%module "mylib::primitives"

%{

  namespace mylib {
    namespace primitives {
      template<class T>
      class A {
      public:
        static T get_17(){ return 17; }
        static int size(){ return sizeof(T); }
      };
    };
  };

%}

namespace mylib {
  namespace primitives {
    template<class T>
    class A {
    public:
      static T get_17();
      static int size();
    };
    %template(ALong) A<long int>;
    %template(AInt) A<int>;
    %template(AShort) A<short>;
    %template(ASChar) A<signed char>;
  };
};
