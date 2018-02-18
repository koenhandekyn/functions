require 'spec_helper'

describe "enumerable" do

  it "zip_map" do
    expect([1,2,3].zip([2,3,4]).map { |a,b| a+b }).to eq([3,5,7])
    expect([1,2,3].zip_map([2,3,4]) { |a,b| a+b }).to eq([3,5,7])
    expect([1,2,3].zip_map([2,3,4],[0,1,0]) { |a,b,c| a+b+c }).to eq([3,6,7])
    expect([1,2,3].zip_map([2,3,4]).with_index { |(a,b),n| a+b+n }).to eq([3,6,9])
  end

  it "transpose" do
    expect([[1,2,3]].transpose).to eq([[1],[2],[3]])
    expect([[1,2,3],[:a,:b,:c]].transpose).to eq([[1,:a],[2,:b],[3,:c]])
  end

  it "zip, unzip" do
    ns = [1,2,3]
    as = [:a,:b,:c]
    expect(ns.zip(as).unzip).to eq([ns, as])
  end

  it "split_in" do
    expect([1,2,3].split_in(1)).to eq([[1,2,3]])
    expect([1,2,3].split_in(2)).to eq([[1,2],[3]])
    expect([1,2,3].split_in(3)).to eq([[1],[2],[3]])
    expect([1,2,3].split_in(4)).to eq([[1],[2],[3],[]]) # do we want this ? length 3 ? or lenght 4 ?
    expect([1,2,3].split_in_half).to eq([[1,2],[3]])
  end

  it "merge" do
    # starts with ordered sets
    expect([1,3,5].merge([3,4,8])).to eq([1,3,3,4,5,8])
    expect([1,3,5].merge([2])).to eq([1,2,3,5])
    expect([].merge([1,2,3])).to eq([1,2,3])
    expect([1,2,3].merge([])).to eq([1,2,3])
    expect([3,2,1].merge([4,2,1]) { |a,b| a > b }).to eq([4,3,2,2,1,1])
  end

  it "interleave" do
    expect(%w(sex druggs rock roll).interleave([", "," and "," & "]).join("")).to eq("sex, druggs and rock & roll")
    expect([3,1,4].interleave([:a,:d,:b])).to eq([3,:a,1,:d,4,:b])
    expect([3,1,4].interleave([:a,:d])).to eq([3,:a,1,:d,4])
    expect([3,1,4].interleave([:a])).to eq([3,:a,1,4])
    expect([3,1,4].interleave([])).to eq([3,1,4])
  end

  it "zip_hash" do
    ab = {a: 'a', b: 'b'}
    ad = {a: 'a', d: 'd'}
    cb = {c: 'c', b: 'b'}
    expect(ab.zip_hash_left(ad)).to eq({a: ['a','a'], b:['b',nil]})
    expect(ab.zip_hash_left(cb)).to eq({a: ['a',nil], b:['b','b']})
    expect(ad.zip_hash_left(cb)).to eq({a: ['a',nil], d:['d',nil]})
    expect(ab.zip_hash_inner(ad)).to eq({a:['a','a']})
    expect(ab.zip_hash_inner(cb)).to eq({b:['b','b']})
    expect(ad.zip_hash_inner(cb)).to eq({})
  end

  it "map_values" do
    ab = {a: 1, b: 2}
    expect(ab.map_values { |x| x*2}).to eq({a: 2, b: 4})
    expect(ab.map_values { |x| x.even? }).to eq({a: false, b: true})
  end

  it "map_values_recurse" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    expect(abcde.map_values_recurse { |x| x*2}).to eq({a: 2, b: 4, c: { d: 2, e: 0}})
    expect(abcde.map_values_recurse { |x| x.even? }).to eq({a: false, b: true, c: { d:false, e: true}})
  end

  it "map_keys" do
    ab = {a: 1, b: 2}
    expect(ab.map_keys { |k| k.to_s }).to eq({"a" => 1, "b" => 2})
    expect(ab.map_keys { |k| k.to_s[0].ord }).to eq({ 97 => 1, 98 => 2 })
    expect(ab.map_keys { |k| k.to_s.length }).to eq({ 1 => 2 })
  end

  it "map_keys_recurse" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    expect(abcde.map_keys_recurse { |k| k.to_s }).to eq({"a" => 1, "b" => 2, "c" => { "d" => 1, "e" => 0 }})
  end

  it "map_hash" do
    ab = {a: 1, b: 2}
    expect(ab.map_hash { |k,v| [k.to_s, v*2] }).to eq({"a" => 2, "b" => 4})
    expect(ab.map_hash { |k,v| [k.to_s[0].ord, v.even?] }).to eq({97 => false, 98 => true})
    expect(ab.map_hash { |k,v| [k.to_s.length, v.even?] }).to eq({1 => true})
  end

  it "map_recursive" do
    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }
    expect(abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s, v] : [k.to_s, v*2] }).to eq({"a" => 2, "b" => 4, "c" => { "d" => 2, "e" => 0 }})
    expect(abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s[0].ord, v] : [k.to_s[0].ord, v.even?] }).to eq({97 => false, 98 => true, 99 => { 100 => false, 101 => true }})
    expect(abcde.map_recurse { |k,v| v.is_a?(Hash) ? [k.to_s.length, v] : [k.to_s.length, v.even?] }).to eq({1 => { 1=>true } })
  end

  it "map_keys_and_values" do

    s = ->(x) { x.to_s }
    s_ord = ->(x) { x.to_s[0].ord }
    s_length = ->(x) { x.to_s.length }
    times_2 = ->(x) { x * 2 }
    even = ->(x) { x.even? }

    abcde = {a: 1, b: 2, c: { d: 1, e: 0 } }

    expect(abcde.map_keys_and_values(s, times_2)).to eq({"a" => 2, "b" => 4, "c" => { "d" => 2, "e" => 0 }})
    expect(abcde.map_keys_and_values(s_ord, even)).to eq({97 => false, 98 => true, 99 => { 100 => false, 101 => true }})
    expect(abcde.map_keys_and_values(s_length, even)).to eq({1 => { 1=>true } })

  end

  it "counted_set" do
    expect([1,2,3,2,2,1,2].counted_set).to eq({1 => 2, 2 => 4, 3 => 1})
    expect(['a','b','a','d'].counted_set).to eq({'a' => 2, 'b' => 1, 'd' => 1})
  end

  it "grouped_by" do
    expect([1,2,3,2,2,1,2].grouped_by { |x| x.odd? }).to eq([[1,3,1],[2,2,2,2]])
    expect(%w(some words are longer then others).grouped_by { |x| x.length > 3 }).to eq([%w(some words longer then others),%w(are)])
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
    expect(multiplied.length).to eq(2)
    expect(multiplied['main_1'].length).to eq(4)

  end
end
