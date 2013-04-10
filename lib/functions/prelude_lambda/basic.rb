module Functions

  module Prelude

    Id = ->(x) { x }

    Const = ->(c, x) { c }

    Split_In = ->(n, xs) { xs.each_slice((xs.length+1)/n).to_a }

    Split_In_Half = Split_In.curry.(2)

    Merge_By = ->(f, xs, ys) do

      return xs if ys.empty?
      return ys if xs.empty?

      x, *xt = xs
      y, *yt = ys

      return Merge_By.(f, xt, ys) >> x if f.nil? ? x <= y : f.(x) <= f.(y)
      return Merge_By.(f, xs, yt) >> y

    end

    Merge = Merge_By.partial(nil)

    Compose = ->(f, g, x) { f.(g.(x)) }.curry

    # Manually curried version
    # ComposeCurried = ->(f) { ->(g) { ->(x) { f.(g.(x)) } } }

    After = ->(f, g, x) {
      f = Par.(f) if Array === f;
      g = Par.(g) if Array === g;
      g.(f.(x))
    }.curry

    # Manually Curried Version
    # AfterCurried = ->(f) { ->(g) { ->(x) {
    #  f = Par.(f) if Array === f;
    #  g = Par.(g) if Array === g;
    #  g.(f.(x))
    # } } }

    Send = ->(m, o) { o.send(m) }.curry

    Flatten = Send.(:flatten)
    # Flatten = ->(a) { a.flatten }

    Reverse = Send.(:reverse)
    # Reverse = ->(a) { a.reverse }

    Length = Send.(:length)
    # Length = ->(x) { x.length }

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