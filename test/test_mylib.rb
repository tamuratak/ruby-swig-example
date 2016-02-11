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
    Callback::bar()
    assert_equal([1.1, 2.1],
                 Callback::foo(){ [1.1, 2.1] })
#    Callback::foo() { 
#        raise StandardError 
#    }
  end

end

