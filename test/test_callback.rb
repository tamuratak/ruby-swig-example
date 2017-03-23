require "test/unit"
require "mylib"

class TestEnum < Test::Unit::TestCase
  include Mylib::Callback

  class Derived < Base
    def ret_m
      2
    end
  end

  def test_get_m
    assert_equal(1, get_m(Base.new))
    assert_equal(2, get_m(Derived.new))
  end

end
