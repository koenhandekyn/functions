require 'examples/prelude_lambda'
require 'examples/prelude_meta'

#require 'test/unit'
require 'minitest/autorun'
require 'minitest/benchmark'

#require "minitest/reporters"
# MiniTest::Reporters.use! # add this to your run configuration

include PreludeLambdaUsage
include PreludeMetaUsage

class TestPrelude < MiniTest::Unit::TestCase

  include Functions::Prelude

  def test_sum_of_squares
    assert_performance_linear 0.99 do |n| # n is a range value
      100.times { Sum_Of_Squares.((1..n).to_a) }
    end
    assert_performance_linear 0.99 do |n| # n is a range value
      100.times { sum_of_squares((1..n).to_a) }
    end
  end

  def test_average
    assert_performance_linear 0.99 do |n| # n is a range value
      100.times { Average.((1..n).to_a) }
    end
    assert_performance_linear 0.99 do |n| # n is a range value
      100.times { average((1..n).to_a) }
    end
  end

end
