module Functions

  module Prelude

    # the identity function
    Id = ->(x) { x }

    # the constant function
    Const = ->(c, x) { c }

    # make a function resilient to nil inputs
    Maybe = ->(fn) { ->(x) { fn.(x) unless x.nil? } }    

    # splits a list xs in peices of size n
    Split_In = ->(n, xs) { xs.each_slice((xs.length+1)/n).to_a }

    # splits a list in half
    Split_In_Half = Split_In.curry.(2)

    # merges two ordered lists by a function f that compares the values
    # if no function is given the values are compared by the "<" operator
    Merge_By = ->(f, xs, ys) do

      return xs if ys.empty?
      return ys if xs.empty?

      x, *xt = xs
      y, *yt = ys

      return Merge_By.(f, xt, ys) >> x if f.nil? ? x <= y : f.(x) <= f.(y)
      return Merge_By.(f, xs, yt) >> y

    end

    # merges two list by the natural comparison operator <
    Merge = Merge_By.partial(nil)

    # composes two functions
    Compose = ->(f, g, x) { f.(g.(x)) }.curry

    # manually curried version of the Compose function
    ComposeCurried = ->(f) { ->(g) { ->(x) { f.(g.(x)) } } }

    # composes two functions in reverse sequence
    After = ->(f, g, x) {
      f = Par.(f) if Array === f;
      g = Par.(g) if Array === g;
      g.(f.(x))
    }.curry

    # manually curried Version of the After composition function
    AfterCurried = ->(f) { ->(g) { ->(x) {
      f = Par.(f) if Array === f;
      g = Par.(g) if Array === g;
      g.(f.(x))
    } } }

    # sends the message m to an object o
    #
    # @param [Symbol] the method to be called on the object o
    # @return the result of calling the message m on the object o
    Send = ->(m, o) { o.send(m) }.curry

    # Flattens an array
    #
    # @param [#flatten] the array to flatten
    Flatten = Send.(:flatten)

    # Reverses an array
    #
    # @param [#reverse] the array to reverse
    Reverse = Send.(:reverse)

    # Returns the length
    Length = Send.(:length)

    Foldl = ->(f, i, a) { a.inject(i) { |r, x| f.(r, x) } }.curry

    ReduceLeft = ->(f, a) { a.inject { |r, x| f.(r, x) } }.curry

    Foldr = ->(f, i, a) { Foldl.(f, i, a.reverse) }

    ReduceRight = ->(f, a) { ReduceLeft.(f, a.reverse) }.curry

    Zip = ->(a, b) { a.zip(b) }.curry

    Merge_Hash = ->(as, bs) { as.merge(bs) { |k, a, b| [a, b] } }.curry

    Zip_Hash_Left = ->(as, bs) { as.each_with_object({}) { |(k, a), h| h[k] = [a, bs[k]]; h } }.curry

    Zip_Hash_Inner = ->(as, bs) { as.each_with_object({}) { |(k, a), h| b = bs[k]; h[k] = [a, b] if b; h } }.curry

    Zip_Hash_Right = ->(as, bs) { bs.each_with_object({}) { |(k, b), h| h[k] = [as[k], b]; h } }.curry

    Map = ->(f, a) { a.map { |x| f.(x) } }.curry

    Map_Hash = ->(f, h) { Hash[h.map{|k, v| [k, f.(v)] }] }.curry     

    Filter = ->(f, xs) { xs.select { |x| f.(x) } }.curry

    Parallel = ->(f, g, x) { [f.(x), g.(x)] }.curry

    Par = ->(fs, x) { fs.map { |f| f.(x) } }.curry

    Intersect = ->(as) { as.inject(:&) }

    Group = ->(f,a) { a.group_by(&f) }.curry 

    Values = Send.(:values)

    # TODO investigate semantics
    Partition = ->(f) { Group.(f) > Values } 

    FromTo = ->(from) { ->(to) { Range.new(from, to) } }

    FromOneTo = FromTo.(1)

    Count_By = ->(f,a) { a.inject( Hash.new(0) ) { |h,e| h[f.(e)] += 1; h } }.curry
    # count_by = ->(f) { group_by.( f ) < map_hash.( send.(:length) ) }    
    
    Count = ->(a) { a.inject( Hash.new(0) ) { |h,e| h[e] += 1; h } } # probably a bit faster   
    # count = count_by.(identity) # alternative definition (generic)

  end

end