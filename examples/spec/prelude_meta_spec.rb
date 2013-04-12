require_relative '../prelude_meta'

include PreludeMetaUsage

describe PreludeMetaUsage, "basic meta prelude usage" do

  it "squares" do
    squares([1, 2, 3]).should == [1, 4, 9]
    squares_bis([1, 2, 3]).should == [1, 4, 9]
  end

  it "evens and odds" do
    evens([1, 2, 3, 4, 5]).should == [2, 4]
    odds([1, 2, 3, 4, 5]).should == [1, 3, 5]
  end

  it "takes sums of squares" do
    sum_of(:square, [2, 3, 1]).should == 2*2+3*3+1*1
    sum_of(->(x) { x*x }, [2, 3, 1]).should == 2*2+3*3+1*1
    sum_of_squares([2, 3, 4]).should == 2*2+3*3+4*4
    sum_of_squares_bis([2, 3, 4]).should == 2*2+3*3+4*4
  end

  it "takes sums by some variant definitions" do
    sum_bis([1, 2, 3]).should == 1+2+3
  end

  it "takes averages by some variant definitions" do
    average_bis([2, 3, 8]).should == 4
    average_tris([2, 3, 8]).should == 4
  end

end
