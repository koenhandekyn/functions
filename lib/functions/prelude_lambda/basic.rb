module Functions

  module Prelude

    # the identity function
    Id = ->(x) { x }

    # the constant function
    Const = ->(c, x) { c }

    # splits a list xs in peices of size n
    Split_In = ->(n, xs) { xs.each_slice((xs.length+1)/n).to_a }

    # splits a list in half
    Split_In_Half = Split_In.curry.(2)

    # merges two lists by a function f that compares the values
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

    #
    Foldl = ->(f, i, a) { a.inject(i) { |r, x| f.(r, x) } }.curry

    ReduceLeft = ->(f, a) { a.inject { |r, x| f.(r, x) } }.curry

    Foldr = ->(f, i, a) { Foldl.(f, i, a.reverse) }

    ReduceRight = ->(f, a) { ReduceLeft.(f, a.reverse) }.curry

    Zip = ->(a, b) { a.zip(b) }.curry

    Map = ->(f, a) { a.map { |x| f.(x) } }.curry

    Filter = ->(xs, f) { xs.select { |x| f.(x) } }.curry

    Parallel = ->(f, g, x) { [f.(x), g.(x)] }.curry

    Par = ->(fs, x) { fs.map { |f| f.(x) } }.curry

    Intersect = ->(as) { as.inject(:&) }

    FromTo = ->(from) { ->(to) { Range.new(from, to) } }

    FromOneTo = FromTo.(1)

  end

end