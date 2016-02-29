require "test/unit"
require "mylib"

class TestEnum < Test::Unit::TestCase
  include Mylib
  include Mylib::Enum

  def test_stl
    assert_equal(3, Stl::vec_len(["a", "b", "c"]))
    assert_equal("foo", 
                 Stl::get_hash_x({"x" => "foo"}) )
    assert_equal("bar", 
                 Stl::first_string( [["bar", "foo"], ["xxx"]] ))
    a = Stl::A.new
    b = Stl::A.new
    assert_equal(a.get_address, a.get_address)
    assert( a.get_address != b.get_address )
    assert( a.get_address != Stl.ret_a(a).get_address )
    assert_equal( a.get_address,
                  Stl.ret_ref_a(a).get_address)
    assert_equal( a.get_address,
                  Stl.ret_ref_a2(a).get_address)
    assert_equal( a.get_address,
                  Stl.ret_ptr_a(a).get_address)
    assert_equal( a.get_address,
                  Stl.first_ref_a([a]).get_address)
    assert_equal( a.get_address,
                  Stl.first_ptr_a([a]).get_address)
  end

  def test_stl_StdVecAptr
    a = Stl::A.new
    arry = Stl::StdVectorAptr.new([a, Stl::A.new])
    assert_equal(arry[0].get_address,
                 a.get_address)

    vec_ = Stl::CreateVec(10)
    vec = vec_.get_p
    assert_equal(Stl::get_a_from_vec(vec, 3).get_address,
                 Stl::vec_to_pvec(vec)[3].get_address)
  end

#  def test_stl_StdVecAptr_gc
#    10000.times do
#      Stl::CreateVec(10000000)
#      GC.start
#    end
#    sleep 100
#  end

  def test_stl_VecAptr
#    vec = Stl::CreateVecAptr(10)
#    assert_equal(Stl::get_a_from_vec(vec, 3).get_address,
#                 Stl::vec_to_pvec(vec)[3].get_address)
#    10000.times do
#      Stl::CreateVecAptr(10000000)
#      GC.start
#    end
#    sleep 100
  end

  def test_enum
    assert_equal(K::A,
                 K.f_enum(K::A))
    assert_equal([K::A, K::B],
                 K.f_enum_v([K::A, K::B]))
    assert_equal([K::A, K::B],
                 K.f_enum_v2([K::A, K::B]))
  end

  def test_typemap
    assert_equal(3, Typemap.fv(3))
    assert_equal([1, 2],
                 Typemap.fvec([1, 2]))
  end

  def test_template
    Template::AInt.new(3)
  end

  def test_callback
    ret = Callback::call_block([1, 2]){|*a|
      a
    }
    assert_equal([1, 2], ret)
    a = 0
    assert_nothing_raised do
      Callback::call_no_raise{
        a = 1
        raise StandardError
        raise Object.new
      }
    end
    assert_equal(1, a)
    assert_raise(RuntimeError){
      Callback::call_block([1]) {1}
    }
  end

  def test_klass
    x = Class::A::Create(1.0, 2.0)
    assert_equal(1.0, x.get_m )
  end

  def test_multi
    a = Mylib::Multia::A.new
    assert_equal(1.7, Mylib::Multib::get_a_val(a))
  end

  def test_primitives
    assert 8 == Mylib::Primitives::ALong::size || 4 == Mylib::Primitives::ALong::size
    assert 8 == Mylib::Primitives::AInt::size || 4 == Mylib::Primitives::AInt::size
    assert_equal(2, Mylib::Primitives::AShort::size)
    assert_equal(1, Mylib::Primitives::ASChar::size)
  end
end

