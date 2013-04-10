require_relative '../examples/prelude_usage'
require_relative '../examples/prelude_meta_usage'

include PreludeUsage
include PreludeUsageWithDefs

require 'benchmark'

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Sum_Of_Squares(n=#{n}): ") { (100000/n).times { Sum_Of_Squares.((1..n).to_a) } }
    b.report("sum_of_squares(n=#{n}): ") { (100000/n).times { sum_of_squares ((1..n).to_a) } }
  end
end

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Average(n=#{n}): ") { (100000/n).times { Average.((1..n).to_a) } }
    b.report("average(n=#{n}): ") { (100000/n).times { average ((1..n).to_a) } }
  end
end

[10, 100, 1000, 10000].each do |n|
  Benchmark.bm(40) do |b|
    b.report("Sum.(n=#{n}): ") { (100000/n).times { Sum.((1..n).to_a) } }
    b.report("sum(n=#{n}): ") { (100000/n).times { sum((1..n).to_a) } }
    b.report("sum_bis(n=#{n}): ") { (100000/n).times { sum_bis((1..n).to_a) } }
    b.report("sum_tris(n=#{n}): ") { (100000/n).times { sum_tris((1..n).to_a) } }
    b.report("sum_quater(n=#{n}): ") { (100000/n).times { sum_quater((1..n).to_a) } }
  end
end

[10, 100, 1000].each do |n|
  random_array = (0..n).to_a.shuffle
  Benchmark.bm(40) do |b|
    b.report("lambda/merge_sort(n=#{n}): ") { (100000/n).times { Merge_Sort.(random_array) } }
    b.report("def/merge_sort(n=#{n}): ") { (100000/n).times { merge_sort(random_array) } }
  end
end

[10, 100, 1000].each do |n|
  random_array = (0..n).to_a.shuffle
  Benchmark.bm(40) do |b|
    b.report("lambda/quick_sort(n=#{n}): ") { (100000/n).times { Quick_Sort.(random_array) } }
    # b.report("lambda/quick_sort/nil(n=#{n}): ") { (100000/n).times { Quick_Sort_By.(nil, random_array) } } # the same by definition
    b.report("lambda/quick_sort/identity(n=#{n}): ") { (100000/n).times { Quick_Sort_By.(Id, random_array) } }
    b.report("def/quick_sort(n=#{n}): ") { (100000/n).times { quick_sort(random_array) } }
  end
end