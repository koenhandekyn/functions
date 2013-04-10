require 'functional'

module PreludeMetaUsage

  include Functional::PreludeMeta

  def power(x, p)
    x ** p
  end

  def square(x)
    power(x, 2)
  end

  def_map :squares, :square

  def squares_bis(a)
    map(a, :square)
  end

  def_map :squares_tris, ->(x) { x**2 }

  define :squares_quater, as: { map: ->(x) { x**2 } }

  define :squares_quinquies, as: { map: :square }

  def_method :even?

  # same as above
  # def even?(a)
  #   a.even?
  # end

  def_filter :evens, :even?

  # same as above
  # filter :evens, :even?

  def_filter :odds, ->(x) { ! x.even? }

  define :evens_bis, as: { filter: :even? }

  def_compose :sum_of_squares, :sum, :squares

  def sum_of_squares_bis(a)
    compose(:sum, :squares, a)
  end

  define :sum_of_squares_tris, as: { compose: [:sum, :squares] }

  def divide(arr)
    arr.inject { |a,b| a/b }
  end

  def_parallel :sum_length, :sum, :length

  def_after :average, :sum_length, :divide

  def average_bis(a)
    after([:sum, :length], :divide, a)
  end

  define :average_tris, as: { :after => [ :sum_length, :divide ] }

  define :after => [ :sum_length, :divide ], as: :average_quater

  def inc_with(f, n, m)
    m + f(f).(n)
  end

  # can this be improved on ?
  # a definition as composition ?
  def sum_of(f, a)
    a.inject(0) { |r, x| r + f(f).(x) }
  end

  def add(a,b)
    a+b
  end

  def_foldl :sum_bis, :add, 0

  define :sum_tris, as: { foldl: [:add, 0]}

  define foldl: [:add, 0], as: :sum_quater

end