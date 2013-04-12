require 'functions'

module PreludeMetaUsage

  include Functions::PreludeMeta

  # returns x to the power of p
  def power(x, p) x ** p end

  # returns x^2
  def square(x) power(x, 2) end

  # returns the list of the squares
  def squares(a) map(a, :square) end

  define :squares_bis, as: { map: :square }

  # test
  # def_map :squares, :square
  # def_map :squares_tris, ->(x) { x**2 }
  # define :squares, as: { map: ->(x) { x**2 } }

  # returns all elements of an enumerable that are even
  define :evens, as: { filter: :even? }

  # def_filter :evens, :even?

  # filter :evens, :even?

  define :odds, as: { filter: :odd? }

  # def_filter :odds, ->(x) { ! x.even? }

  def sum_of_squares(a) compose(:sum, :squares, a) end

  define :sum_of_squares_bis, as: { compose: [:sum, :squares] }

  # compose :sum_of_squares, :sum, :squares

  def average_bis(a) after([:sum, :length], :divide, a) end

  define :average_tris, as: { :after => [ :sum_length, :divide ] }

  # after :average_quater, :sum_length, :divide

  def inc_with(f, n, m) m + f(f).(n) end

  def sum_of(f, a) a.inject(0) { |r, x| r + f(f).(x) } end

  def add(a,b) a+b end

  define :sum_bis, as: { foldl: [:add, 0]}

  # foldl :sum_bis, :add, 0

  # define foldl: [:add, 0], as: :sum_quater

end