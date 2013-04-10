module Functional
  module Prelude

    Sum = ->(arr) { arr.inject(0, :+) }

    Multiply = ->(arr) { arr.inject(1, :*) }

    Divide = ->(arr) { arr.inject(:/) }
    # Divide = ->(arr) { arr.inject { |a,b| a/b } }

    IsDivisor = ->(a, c) { a % c == 0 }
    Divisors = ->(a) { Filter.(FromOneTo.(a), IsDivisor.partial(a)) }
    # Divisors = ->(a) { Filter.(FromOneTo.(a)).(IsDivisor.partial(a)) }
    # TODO without params ???
    # Divisors = Filter < ???

    Gcd = ->(a, b) { b == 0 ? a : Gcd.(b, a % b) } # euclid algorithm

    GcdA1 = Max < Intersect < Map.(Divisors) # litteral translation of the definition
    GcdA2 = ->(arr) { arr.inject { |a, r| Gcd.(a, r) } } # the gcd of an array as an iteration of the gcd over the elements
    GcdA3 = ReduceLeft.(Gcd) # the same but written without arguments
    GcdA = GcdA3

    Lcm = ->(a, b) { a*b / Gcd.(a, b) } # mathematical law

    LcmA1 = ->(arr) { arr.inject { |a, r| Lcm.(a, r) } } # the lcm of an array as an iteration of the lcm over the elements
    LcmA2 = ReduceLeft.(Lcm) # the same but without arguments
    LcmA = LcmA2

  end
end