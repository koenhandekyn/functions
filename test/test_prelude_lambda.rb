require 'examples/prelude_lambda'

require 'test/unit'
#require 'minitest/autorun'
#require 'minitest/benchmark'
#require "minitest/reporters"
# MiniTest::Reporters.use! # add this to your run configuration

class TestPrelude <Test::Unit::TestCase

  include PreludeLambdaUsage

  def test_examples
    assert_equal Sum_Of_Squares.([2,3,4]) , 2*2+3*3+4*4
    assert_equal Average.([2,3,8]) , 4
    assert_equal Flatten.([[1,2,3],[2,3]]) , [1,2,3,2,3]
    assert_equal Foldl.( ->(n,a) { n/a }, 1.0, [1.0,2.0,3.0] ) , 1.0/1.0/2.0/3.0
    assert_equal Foldr.( ->(n,a) { n/a }, 1.0, [1.0,2.0,3.0] ) , 1.0/3.0/2.0/1.0
    assert_equal Sum_Of.(Square).([2,3,1]) , 2*2+3*3+1*1
  end

  def bench_sum_of_squares
    assert_performance_linear 0.9 do |n| # n is a range value
      Sum_Of_Squares.((1..n).to_a)
    end
  end

end
