require 'spec_helper'

describe Functions::Prelude, "math" do

  it "divides" do
    expect(Divide.([9,2])).to eq(9/2)
    expect(Divide.([8,2,2])).to eq(8/2/2)
  end

  it "power" do
    expect(Power.(2,3)).to eq(9)
    expect(Power.(0,3)).to eq(1)
    expect(Power.(3,2)).to eq(8)
  end

  it "knows about divisors" do
    expect(IsDivisor.(8,2)).to eq(true)
    expect(IsDivisor.(8,3)).to eq(false)
    expect(Divisors.(12).sort).to eq([1,2,3,4,6,12])
  end

  it "knows about range building" do
    expect(FromOneTo.(3)).to eq(1..3)
    expect(FromOneTo.(3).to_a).to eq([1,2,3])
    expect(FromTo.(2).(8).to_a).to eq([2,3,4,5,6,7,8])
  end

  it "knows about gcd" do
    expect(Gcd.(12,9)).to eq(3)
    expect(Gcd.(4,8)).to eq(4)
    expect(GcdA.([12,9,6])).to eq(3)
    expect(GcdA.([4,8,2])).to eq(2)
  end

  it "knows about lcm" do
    expect(Lcm.(12,9)).to eq(36)
    expect(Lcm.(6,8)).to eq(24)
    expect(LcmA.([12,9])).to eq(36)
    expect(LcmA.([12,9,2])).to eq(36)
  end

end



