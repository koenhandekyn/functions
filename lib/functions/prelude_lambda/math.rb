module Functions

  module Prelude

    Max = Send.(:max)

    Min = Send.(:min)

    Sum = ->(arr) { arr.inject(0, :+) }

    Multiply = ->(arr) { arr.inject(1, :*) }

    Divide = ->(arr) { arr.inject(:/) }

    To_Float = Send.(:to_f)

    Average = Parallel.(Sum,Length) > Map.( To_Float ) > Divide

    Power = ->(p,x) { x**p }.curry

    IsDivisor = ->(a, c) { a % c == 0 }

    Divisors = ->(a) { Filter.(IsDivisor.partial(a), FromOneTo.(a)) }

    Gcd = ->(a, b) { b == 0 ? a : Gcd.(b, a % b) } # euclid algorithm

    GcdA = ReduceLeft.(Gcd)

    Lcm = ->(a, b) { a*b / Gcd.(a, b) } # mathematical law

    LcmA = ReduceLeft.(Lcm)

  end

end
