module Functions

  module Prelude

    Merge_Sort_By = ->(f, xs) do

      return xs if xs.length <= 1 # stopcondition
      
      left, right = Split_In_Half.(xs)
      Merge_By.(f, Merge_Sort_By.(f, left), Merge_Sort_By.(f, right))
    end

    Merge_Sort = Merge_Sort_By.partial(nil)
    # = Merge_Sort_By.partial(Identity)

    Quick_Sort_By = ->(f, list) do
      
      return [] if list.size == 0
      return list if list.size == 1
      
      pivot, *xs = *list
      smaller_than = f.nil? ? ->(y) { y < pivot } : ->(y) { f.(y) < f.(pivot) }
      less, more = xs.partition &smaller_than
      Quick_Sort_By.(f, less) + [pivot] + Quick_Sort_By.(f, more)
    end

    Quick_Sort = Quick_Sort_By.partial(nil)
    # = Quick_Sort_By.partial(Identity)

  end
end