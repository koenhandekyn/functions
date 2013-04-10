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

The library provides two different styles.
One style builds on Lambda's and another style uses meta-programming.
The lambda style is a bit more pure but is currently just a bit slower in performance.

### Lambda Style

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

### Meta Style

The meta style allows you to write functions like this

    require 'functions'

    module PreludeMetaUsage

      include Functions::PreludeMeta

      def power(x, p) x ** p end

      def square(x) power(x, 2) end

      define :squares, as: { map: :square }

      define :evens, as: { filter: :even? }

      define :sum_of_squares_tris, as: { compose: [:sum, :squares] }

      define :average, as: { :after => [ :sum_length, :divide ] }

      define :sum, as: { foldl: [:add, 0]}

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
