require 'functions'

include Functions::Prelude

describe Functions::Prelude, "math" do

  it "divides" do
    Divide.([9,2]).should eq(9/2)
    Divide.([8,2,2]).should eq(8/2/2)
  end

  it "knows about divisors" do
    IsDivisor.(8,2).should eq(true)
    IsDivisor.(8,3).should eq(false)
    Divisors.(12).sort.should eq([1,2,3,4,6,12])
  end

  it "knows about range building" do
    FromOneTo.(3).should eq(1..3)
    FromOneTo.(3).to_a.should eq([1,2,3])
    FromTo.(2).(8).to_a.should eq([2,3,4,5,6,7,8])
  end

  it "knows about gcd" do
    Gcd.(12,9).should eq(3)
    Gcd.(4,8).should eq(4)
    GcdA.([12,9,6]).should eq(3)
    GcdA.([4,8,2]).should eq(2)
  end

  it "knows about lcm" do
    Lcm.(12,9).should eq(36)
    Lcm.(6,8).should eq(24)
    LcmA.([12,9]).should eq(36)
    LcmA.([12,9,2]).should eq(36)
  end

end



