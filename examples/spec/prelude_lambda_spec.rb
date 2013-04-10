require_relative '../prelude_lambda'

include PreludeLambdaUsage

describe PreludeLambdaUsage, "basic lambda prelude usage" do

  it "sums" do
    Sum_Of_Squares.([2, 3, 4]).should == 2*2+3*3+4*4
    Sum_Of.(Square).([2, 3, 1]).should == 2*2+3*3+1*1
  end

  it "averages" do
    Average.([2, 3, 8]).should == 4
  end

  it "flattens" do
    Flatten.([[1, 2, 3], [2, 3]]).should == [1, 2, 3, 2, 3]
  end

  it "folds" do
    Foldl.(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0]).should == 1.0/1.0/2.0/3.0
    Foldr.(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0]).should == 1.0/3.0/2.0/1.0
  end

  it "knows about GCD alternatives" do
    # test variant implementations
    Gcd1.(4,8).should == 4
    Gcd2.(4,8).should == 4
    GcdA1.([4,8,2]).should eq(2)
    GcdA2.([4,8,2]).should eq(2)
    GcdA3.([4,8,2]).should eq(2)
    GcdA4.([4,8,2]).should eq(2)
  end

  it "knows about LCM variations" do
    # test variant implementations
    LcmA1.([12,9,2]).should eq(36)
    LcmA2.([12,9,2]).should eq(36)
  end


  #def bench_sum_of_squares
  #  assert_performance_linear 0.9 do |n| # n is a range value
  #    Sum_Of_Squares.((1..n).to_a)
  #  end
  #end

end
