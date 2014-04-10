require 'functions/prelude_enumerable'

describe "enumerable" do

  it "zip_map" do
    [1,2,3].zip([2,3,4]).map { |a,b| a+b }.should eq([3,5,7])
    [1,2,3].zip_map([2,3,4]) { |a,b| a+b }.should eq([3,5,7])
    [1,2,3].zip_map([2,3,4],[0,1,0]) { |a,b,c| a+b+c }.should eq([3,6,7])
    [1,2,3].zip_map([2,3,4]).with_index { |(a,b),n| a+b+n }.should eq([3,6,9])
  end

  it "transpose" do
    [[1,2,3]].transpose.should eq([[1],[2],[3]])
    [[1,2,3],[:a,:b,:c]].transpose.should eq([[1,:a],[2,:b],[3,:c]])
  end

  it "zip, unzip" do
    ns = [1,2,3]
    as = [:a,:b,:c]
    ns.zip(as).unzip.should eq([ns, as])
  end

  it "split_in" do
    [1,2,3].split_in(1).should eq([[1,2,3]])
    [1,2,3].split_in(2).should eq([[1,2],[3]])
    [1,2,3].split_in(3).should eq([[1],[2],[3]])
    [1,2,3].split_in(4).should eq([[1],[2],[3],[]]) # do we want this ? length 3 ? or lenght 4 ?
    [1,2,3].split_in_half.should eq([[1,2],[3]])
  end

  it "merge" do
    # starts with ordered sets
    [1,3,5].merge([3,4,8]).should eq([1,3,3,4,5,8])
    [1,3,5].merge([2]).should eq([1,2,3,5])
    [].merge([1,2,3]).should eq([1,2,3])
    [1,2,3].merge([]).should eq([1,2,3])
    [3,2,1].merge([4,2,1]) { |a,b| a > b }.should eq([4,3,2,2,1,1])
  end

  it "interleave" do
    %w(sex druggs rock roll).interleave([", "," and "," & "]).join("").should eq("sex, druggs and rock & roll")
    [3,1,4].interleave([:a,:d,:b]).should eq([3,:a,1,:d,4,:b])
    [3,1,4].interleave([:a,:d]).should eq([3,:a,1,:d,4])
    [3,1,4].interleave([:a]).should eq([3,:a,1,4])
    [3,1,4].interleave([]).should eq([3,1,4])
  end

  it "zip_hash" do
    ab = {a: 'a', b: 'b'}
    ad = {a: 'a', d: 'd'}
    cb = {c: 'c', b: 'b'}
    ab.zip_hash_left(ad).should eq({a: ['a','a'], b:['b',nil]})
    ab.zip_hash_left(cb).should eq({a: ['a',nil], b:['b','b']})
    ad.zip_hash_left(cb).should eq({a: ['a',nil], d:['d',nil]})
    ab.zip_hash_inner(ad).should eq({a:['a','a']})
    ab.zip_hash_inner(cb).should eq({b:['b','b']})
    ad.zip_hash_inner(cb).should eq({})
  end

  it "map_values" do
    ab = {a: 1, b: 2}
    ab.map_values { |x| x*2}.should == {a: 2, b: 4}
    ab.map_values { |x| x.even? }.should == {a: false, b: true}
  end

  it "map_values_recurse" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    abcde.map_values_recurse { |x| x*2}.should == {a: 2, b: 4, c: { d: 2, e: 0}}
    abcde.map_values_recurse { |x| x.even? }.should == {a: false, b: true, c: { d:false, e: true}}
  end

  it "map_keys" do
    ab = {a: 1, b: 2}
    ab.map_keys { |k| k.to_s }.should == {"a" => 1, "b" => 2}
    ab.map_keys { |k| k.to_s[0].ord }.should == { 97 => 1, 98 => 2 }
    ab.map_keys { |k| k.to_s.length }.should == { 1 => 2 }
  end

  it "map_keys_recurse" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    abcde.map_keys_recurse { |k| k.to_s }.should == {"a" => 1, "b" => 2, "c" => { "d" => 1, "e" => 0 }}
  end

  it "map_hash" do
    ab = {a: 1, b: 2}
    ab.map_hash { |k,v| [k.to_s, v*2] }.should == {"a" => 2, "b" => 4}
    ab.map_hash { |k,v| [k.to_s[0].ord, v.even?] }.should == {97 => false, 98 => true}
    ab.map_hash { |k,v| [k.to_s.length, v.even?] }.should == {1 => true}
  end

  it "map_recursive" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s, v] : [k.to_s, v*2] }.should == {"a" => 2, "b" => 4, "c" => { "d" => 2, "e" => 0 }}
    abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s[0].ord, v] : [k.to_s[0].ord, v.even?] }.should == {97 => false, 98 => true, 99 => { 100 => false, 101 => true }}
    abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s.length, v] : [k.to_s.length, v.even?] }.should == {1 => true, 1 => { 1=>true } }
  end

  it "map_keys_and_values" do
    
    s = ->(x) { x.to_s }
    s_ord = ->(x) { x.to_s[0].ord }
    s_length = ->(x) { x.to_s.length }
    times_2 = ->(x) { x * 2 }
    even = ->(x) { x.even? }
    
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }

    abcde.map_keys_and_values(s, times_2).should == {"a" => 2, "b" => 4, "c" => { "d" => 2, "e" => 0 }}
    abcde.map_keys_and_values(s_ord, even).should == {97 => false, 98 => true, 99 => { 100 => false, 101 => true }}
    abcde.map_keys_and_values(s_length, even).should == {1 => true, 1 => { 1=>true } }

  end

  it "counted_set" do
    [1,2,3,2,2,1,2].counted_set.should eq({1 => 2, 2 => 4, 3 => 1})
    ['a','b','a','d'].counted_set.should eq({'a' => 2, 'b' => 1, 'd' => 1})
  end

  it "grouped_by" do
    [1,2,3,2,2,1,2].grouped_by { |x| x.odd? }.should eq([[1,3,1],[2,2,2,2]])
    %w(some words are longer then others).grouped_by { |x| x.length > 3 }.should eq([%w(some words longer then others),%w(are)])
  end

  it "multi_map" do

    folders = { 'main[2]' => { 'child[3]' => 'leaf', 'simple' => 'leaf' } }

    multiply_folder = ->(k,v) do
      match = k.match(/(.*)\[(\d+)\]/)
      k, count = match ? [match[1], match[2].to_i] : [k, nil]
      if count
        (1..count).map { |i| ["#{k}_#{i}",v] }
      else
        [[k,v]]
      end
    end

    multiplied = folders.multi_map &multiply_folder
    multiplied.length.should eq(2)
    multiplied['main_1'].length.should eq(4)

  end
end