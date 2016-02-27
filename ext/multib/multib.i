%module "mylib::multib"

%import "../multia/multia.i"
%include std_vector.i

%{

  namespace mylib {
    namespace multi {
      class A {
      public:
        double get_val() const;
      };
      double get_a_val(const A& a){
        return a.get_val();
      }
    };
  };

%}

namespace mylib {
  namespace multi {
    double get_a_val(const A&);
  };
};
