require "test/unit"
require "mylib"

class TestEigen < Test::Unit::TestCase
  include Mylib

  def test_stl
    assert_equal(3, Stl::vec_len(["a", "b", "c"]))
    assert_equal("foo", 
                 Stl::get_hash_x({"x" => "foo"}) )
    assert_equal("bar", 
                 Stl::first_string( [["bar", "foo"], ["xxx"]] ))
  end

end

