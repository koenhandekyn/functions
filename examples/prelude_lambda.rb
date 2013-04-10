require 'functional'

module PreludeLambdaUsage

  include Functional::Prelude

  Power = ->(p,x) { x**p }.curry
  Square = Power.(2)
  Squares = Map.(Square)
  Sum_Of_Squares1 = Compose.(Sum).(Squares)
  Sum_Of_Squares2 = Sum < Squares
  Sum_Of_Squares = Sum_Of_Squares2

  Average1 = After.( Parallel.(Sum).(Length) ).( Divide )
  Average2 = After.( Par.([Sum,Length]) ).( Divide )
  Average3 = After.( [Sum,Length] ).( Divide )

  Inc_With = ->(f, n, m) { n + f.(m) }.curry
  Sum_Of1 = ->(f,arr) { Foldl.( Inc_With.(f), 0, arr) }.curry
  Sum_Of2 = ->(f) { ->(arr) { Foldl.( Inc_With.(f), 0, arr) } }
  Sum_Of = Sum_Of1

  # GcdA variations
  GcdA1 = Max < Intersect < Map.(Divisors) # litteral translation of the definition
  GcdA2 = ->(arr) { arr.inject { |a, r| Gcd.(a, r) } } # the gcd of an array as an iteration of the gcd over the elements
  GcdA3 = ReduceLeft.(Gcd) # the same but written without arguments

  # LcmA variations
  LcmA1 = ->(arr) { arr.inject { |a, r| Lcm.(a, r) } } # the lcm of an array as an iteration of the lcm over the elements
  LcmA2 = ReduceLeft.(Lcm) # the same but without arguments


end
