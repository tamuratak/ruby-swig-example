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
  end


  def test_enum
    assert_equal(K::A,
                 K.f_enum(K::A))
    assert_equal([K::A, K::B],
                 K.f_enum_v([K::A, K::B]))
    assert_equal([K::A, K::B],
                 K.f_enum_v2([K::A, K::B]))
  end
end

