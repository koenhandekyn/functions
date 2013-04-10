require "functional"

include Functional::PreludeMeta

describe Functional::PreludeMeta, "basic meta prelude usage" do

  it "sums" do
    sum([1, 2, 3]).should == 1+2+3
  end

  it "takes averages" do
    average([2, 3, 8]).should == 4
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
