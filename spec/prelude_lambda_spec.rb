require 'functions'

include Functions::Prelude

describe Functions::Prelude, "basic" do

  Power = ->(p, x) { x**p }.curry
  Square = Power.(2)
  Squares = Map.(Square)

  it "composes" do
    sum_of_squares = Compose.(Sum).(Squares)
    sum_of_squares.([2, 3, 4]).should eq(4+9+16)
  end

  it "has a compose operator" do
    sum_of_squares = Sum < Squares
    sum_of_squares.([2, 3, 4]).should eq(4+9+16)
  end

  it "folds" do
    inc_with = ->(f, n, m) { n + f.(m) }.curry
    sum_of = ->(f, arr) { Foldl.(inc_with.(f), 0, arr) }.curry
    sum_of.(Square).([1,2,3]).should eq(1+4+9)
  end

  it "composes using after with implicit parallel" do
    average = After.([Sum, Length]).(Divide)
    average.([2, 3, 8]).should eq((2+3+8)/3)
  end

  it "mixes parallel with after operator" do
    average = Parallel.(Sum, Length) > Divide
    average.([2, 3, 8]).should eq((2+3+8)/3)
  end

  it "mixes par with after operator" do
    average = Par.([Sum, Length]) > Divide
    average.([2, 3, 8]).should eq((2+3+8)/3)
  end

  it "flattens arrays" do
    Flatten.([[1, 2, 3], [2, 3]]).should eq([1,2,3,2,3])
  end

end