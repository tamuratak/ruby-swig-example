%module "mylib::mod_narray"

%include std_vector.i

%{
#include <vector>
#include <numo/narray.h>

  std::vector<double> ret_vec(char* data, size_t col, size_t row) {
    std::vector<double> ret(col*row);
    memcpy(ret.data(), data, col*row*sizeof(double));
    return ret;
  }

  std::vector<double> ret_vec_2(VALUE na) {
    if(IsNArray(na)) {
      if(RNARRAY_NDIM(na)==2) {
        size_t* shp = RNARRAY_SHAPE(na);
        size_t  col = shp[0];
        size_t  row = shp[1];
        char*  data = RNARRAY_DATA_PTR(na);
        std::vector<double> ret(col*row);
        memcpy(ret.data(), data, row*col*sizeof(double));
        return ret;
      } else {
        rb_raise(rb_eArgError,"ndim != 2.");
      }
    } else {
      rb_raise(rb_eArgError,"NArray expected.");
    }
  }
%}

%typemap(in) (char* data, size_t col, size_t row) {
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
std::vector<double> ret_vec(char* data, size_t col, size_t row);
std::vector<double> ret_vec_2(VALUE na);
