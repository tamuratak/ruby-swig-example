%module "mylib::multia"

%include std_vector.i

%{

  namespace mylib {
    namespace multi {
      class A {
      public:
        double get_val() const { return 1.7; }
      };
    };
  };

%}



%template(MultiaVec) std::vector< double >;

namespace mylib {
  namespace multi {
    class A{
    public:
      double get_val();
    };
  };
};
