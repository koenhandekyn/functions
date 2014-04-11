require 'functions'

module PreludeLambdaUsage

  include Functions::Prelude

  Power = ->(p,x) { x**p }.curry
  Square = Power.(2)
  Squares = Map.(Square)
  SumOfSquares1 = Compose.(Sum).(Squares)
  SumOfSquares2 = Sum < Squares
  SumOfSquares = SumOfSquares2

  IncWith = ->(f, n, m) { n + f.(m) }.curry
  SumOf1 = ->(f,arr) { Foldl.( IncWith.(f), 0, arr) }.curry
  SumOf2 = ->(f) { ->(arr) { Foldl.( IncWith.(f), 0, arr) } }
  SumOf = SumOf1

  # Average variations
  Average1 = After.( Parallel.(Sum).(Length) ).( Divide )
  Average2 = After.( Par.([Sum,Length]) ).( Divide )
  Average3 = After.( [Sum,Length] ).( Divide )

  # Gcd variations
  Gcd1 = ->(a, b) {
    (1..[a,b].min).select { |c| a % c == 0 && b % c == 0 }.max
  }
  Gcd2 = ->(a,b) { (Divisors.(a) & Divisors.(b)).max }

  # GcdA variations
  GcdA1 = Max < Intersect < Map.(Divisors) # litteral translation of the definition
  GcdA2 = ->(arr) { arr.inject { |a, r| Gcd.(a, r) } } # the gcd of an array as an iteration of the gcd over the elements
  GcdA3 = ReduceLeft.(Gcd) # the same but written without arguments

  Greatest = Max
  Common = Intersect
  Dividers = Map.(Divisors)
  GcdA4 = Greatest < Common < Dividers


  # LcmA variations
  LcmA1 = ->(arr) { arr.inject { |a, r| Lcm.(a, r) } } # the lcm of an array as an iteration of the lcm over the elements
  LcmA2 = ReduceLeft.(Lcm) # the same but without arguments

end
