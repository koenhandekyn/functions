require_relative '../prelude_lambda'

include PreludeLambdaUsage

describe PreludeLambdaUsage, "basic lambda prelude usage" do

  it "sums" do
    expect(SumOfSquares.([2, 3, 4])).to eq(2*2+3*3+4*4)
    expect(SumOf.(Square).([2, 3, 1])).to eq(2*2+3*3+1*1)
  end

  it "averages" do
    expect(Average.([2, 3, 8])).to eq(4)
  end

  it "flattens" do
    expect(Flatten.([[1, 2, 3], [2, 3]])).to eq([1, 2, 3, 2, 3])
  end

  it "folds" do
    expect(Foldl.(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0])).to eq(1.0/1.0/2.0/3.0)
    expect(Foldr.(->(n, a) { n/a }, 1.0, [1.0, 2.0, 3.0])).to eq(1.0/3.0/2.0/1.0)
  end

  it "knows about GCD alternatives" do
    # test variant implementations
    expect(Gcd1.(4,8)).to == 4
    expect(Gcd2.(4,8)).to == 4
    expect(GcdA1.([4,8,2])).to eq(2)
    expect(GcdA2.([4,8,2])).to eq(2)
    expect(GcdA3.([4,8,2])).to eq(2)
    expect(GcdA4.([4,8,2])).to eq(2)
  end

  it "knows about LCM variations" do
    # test variant implementations
    expect(LcmA1.([12,9,2])).to eq(36)
    expect(LcmA2.([12,9,2])).to eq(36)
  end


  #def bench_sum_of_squares
  #  assert_performance_linear 0.9 do |n| # n is a range value
  #    Sum_Of_Squares.((1..n).to_a)
  #  end
  #end

end
