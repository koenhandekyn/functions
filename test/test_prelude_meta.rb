require 'examples/prelude_meta'
require 'test/unit'

class TestPreludeExamples < Test::Unit::TestCase

  include PreludeMetaUsage

  def test_examples
    assert_equal squares([1,2,3]), [1,4,9]
    assert_equal squares_bis([1,2,3]), [1,4,9]
    assert_equal squares_tris([1,2,3]), [1,4,9]
    assert_equal squares_quater([1,2,3]), [1,4,9]
    assert_equal squares_quinquies([1,2,3]), [1,4,9]
    assert_equal evens([1,2,3,4,5]), [2,4]
    assert_equal evens_bis([1,2,3,4,5]), [2,4]
    assert_equal odds([1,2,3,4,5]), [1,3,5]
    assert_equal sum_of_squares([2,3,4]), 2*2+3*3+4*4
    assert_equal sum_of_squares_bis([2,3,4]), 2*2+3*3+4*4
    assert_equal sum_of_squares_tris([2,3,4]), 2*2+3*3+4*4
    assert_equal average([2,3,8]) , 4
    assert_equal average_bis([2,3,8]) , 4
    assert_equal average_tris([2,3,8]) , 4
    assert_equal average_quater([2,3,8]) , 4
    assert_equal foldl( ->(n,a) { n/a }, 1.0, [1.0,2.0,3.0] ) , 1.0/1.0/2.0/3.0
    assert_equal foldr( ->(n,a) { n/a }, 1.0, [1.0,2.0,3.0] ) , 1.0/3.0/2.0/1.0
    assert_equal sum_of(:square, [2,3,1]) , 2*2+3*3+1*1
    assert_equal sum_of(->(x){x*x}, [2,3,1]) , 2*2+3*3+1*1
    assert_equal sum([1,2,3]), 1+2+3
    assert_equal sum_bis([1,2,3]), 1+2+3
    assert_equal sum_tris([1,2,3]), 1+2+3
    assert_equal sum_quater([1,2,3]), 1+2+3
    assert_equal min([1,2,3]), 1
    assert_equal max([1,2,3]), 3
    assert_equal from_to(2,3), 2..3
    assert_equal from_one_to(3), 1..3
    assert_equal intersect([[1,2,3], [2,3,4], [2,3,8]]), [2,3]
  end
end

