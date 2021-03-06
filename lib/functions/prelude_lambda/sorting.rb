module Functions

  module Prelude

    MergeSortBy = ->(f, xs) do

      return xs if xs.length <= 1 # stopcondition

      left, right = SplitInHalf.(xs)
      MergeBy.(f, MergeSortBy.(f, left), MergeSortBy.(f, right))
    end

    MergeSort = MergeSortBy.partial(Id)

    QuickSortBy = ->(f, list) do

      return [] if list.size == 0
      return list if list.size == 1

      pivot, *xs = *list
      smaller_than = ->(y) { f.(y) < f.(pivot) }
      less, more = xs.partition &smaller_than
      QuickSortBy.(f, less) + [pivot] + QuickSortBy.(f, more)
    end

    QuickSort = QuickSortBy.partial(Id)
  end
end
