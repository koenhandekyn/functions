# Functional

This library facilitates writing code in a more functional style inside Ruby. 

## Installation

Add this line to your application's Gemfile:

    gem 'functional'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install functional

## Usage

The lambda style allows you to write functions like this

    require 'functions'

    module PreludeLambdaUsage

      include Functions::Prelude

      Power = ->(p,x) { x**p }.curry
      Square = Power.(2)
      Squares = Map.(Square)
      Sum_Of_Squares2 = Sum < Squares

      Average = After.( [Sum,Length] ).( Divide )

      Gcd = ->(a,b) { (Divisors.(a) & Divisors.(b)).max }  # literal translation of the definition, just as an example

      # Gcd of an array
      GcdA1 = Max < Intersect < Map.(Divisors) # literal translation of the definition
      GcdA2 = ReduceLeft.(Gcd) # faster

      # Lcm of an array in function of Lcm of a pair
      LcmA = ReduceLeft.(Lcm) # the same but without arguments

    end

## License

This code is currently copyrighted under the AGPL license.
See <http://www.gnu.org/licenses/agpl.html> for more information.

![AGPL license](http://www.gnu.org/graphics/agplv3-155x51.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
