require_relative '../prelude_meta'

include PreludeMetaUsage

describe PreludeMetaUsage, "basic meta prelude usage" do

  it "squares" do
    squares([1, 2, 3]).should == [1, 4, 9]
    squares_bis([1, 2, 3]).should == [1, 4, 9]
    squares_tris([1, 2, 3]).should == [1, 4, 9]
    squares_quater([1, 2, 3]).should == [1, 4, 9]
    squares_quinquies([1, 2, 3]).should == [1, 4, 9]
  end

  it "evens and odds" do
    evens([1, 2, 3, 4, 5]).should == [2, 4]
    evens_bis([1, 2, 3, 4, 5]).should == [2, 4]
    odds([1, 2, 3, 4, 5]).should == [1, 3, 5]
  end

  it "takes sums of squares and more" do
    sum_of_squares([2, 3, 4]).should == 2*2+3*3+4*4
    sum_of_squares_bis([2, 3, 4]).should == 2*2+3*3+4*4
    sum_of_squares_tris([2, 3, 4]).should == 2*2+3*3+4*4
    sum_of(:square, [2, 3, 1]).should == 2*2+3*3+1*1
    sum_of(->(x) { x*x }, [2, 3, 1]).should == 2*2+3*3+1*1
    sum([1, 2, 3]).should == 1+2+3
    sum_bis([1, 2, 3]).should == 1+2+3
    sum_tris([1, 2, 3]).should == 1+2+3
    sum_quater([1, 2, 3]).should == 1+2+3
  end

  it "takes averages" do
    average([2, 3, 8]).should == 4
    average_bis([2, 3, 8]).should == 4
    average_tris([2, 3, 8]).should == 4
    average_quater([2, 3, 8]).should == 4
  end

  it "folds" do
    foldl(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0]).should == 1.0/1.0/2.0/3.0
    foldr(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0]).should == 1.0/3.0/2.0/1.0
  end

  it "mins and maxes" do
    min([1, 2, 3]).should == 1
    max([1, 2, 3]).should == 3
  end

  it "makes ranges" do
    from_to(2, 3).should == (2..3)
    from_one_to(3).should == (1..3)
  end

  it "intersects arrays" do
    intersect([[1, 2, 3], [2, 3, 4], [2, 3, 8]]).should == [2, 3]
  end

end
