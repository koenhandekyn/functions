require_relative '../examples/prelude_lambda'

include PreludeLambdaUsage
# include PreludeUsageWithDefs

require 'benchmark'

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Sum_Of_Squares(n=#{n}): ") { (100000/n).times { Sum_Of_Squares.((1..n).to_a) } }
  end
end

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Average(n=#{n}): ") { (100000/n).times { Average.((1..n).to_a) } }
  end
end

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Sum.(n=#{n}): ") { (100000/n).times { Sum.((1..n).to_a) } }
  end
end

[10, 100, 1000].each do |n|
  random_array = (0..n).to_a.shuffle
  Benchmark.bm(40) do |b|
    b.report("Merge_Sort(n=#{n}): ") { (100000/n).times { Merge_Sort.(random_array) } }
  end
end

[10, 100, 1000].each do |n|
  random_array = (0..n).to_a.shuffle
  Benchmark.bm(40) do |b|
    b.report("Quick_Sort(n=#{n}): ") { (100000/n).times { Quick_Sort.(random_array) } }
    b.report("Quick_Sort/identity(n=#{n}): ") { (100000/n).times { Quick_Sort_By.(Id, random_array) } }
  end
end