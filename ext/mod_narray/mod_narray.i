%module "mylib::mod_narray"

%include std_vector.i

%{
#include <vector>
#include <numo/narray.h>

  std::vector<double> ret_vec(char* data, size_t row, size_t col) {
    std::vector<double> ret(row*col);
    memcpy(ret.data(), data, row*col*sizeof(double));
    return ret;
  }

%}

%typemap(in) (char* data, size_t row, size_t col) {
  if(IsNArray($input)) {
    if(RNARRAY_NDIM($input)==2) {
      size_t* shp = RNARRAY_SHAPE($input);
      $1 = RNARRAY_DATA_PTR($input);
      $2 = shp[0];
      $3 = shp[1];
    } else {
      rb_raise(rb_eArgError,"ndim != 2.");
    }
  } else {
    rb_raise(rb_eArgError,"NArray expected.");
  }
}

%template(StdVectorDouble) std::vector<double>;
std::vector<double> ret_vec(char* data, size_t row, size_t col);
