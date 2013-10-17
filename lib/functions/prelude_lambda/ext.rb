# reference http://iain.nl/going-crazy-with-to_proc

class Array
  # converts the array into a Proc where
  # the first element is the method name, other elements are the values
  def to_proc
    head, *tail = *self
    Proc.new { |obj, *other| obj.__send__(head, *(other + tail)) }
  end
end

class Proc
  def self.compose(f, g)
    ->(*args) { g[f[*args]] }
  end
  # Composition of Procs (functions): (f+g)(x) = f(g(x))
  def +(g)
    # Prelude::Compose.(self,g)
    ->(x) { self.(g.(x)) }
  end
  # Composition of Procs (functions): (f<g)(x) = f(g(x))
  def <(g)
    # Prelude::Compose.(self,g)
    ->(x) { self.(g.(x)) }
  end
  # Composition of Procs (functions): (f>g)(x) = g(f(x))
  def >(g)
    # Prelude::After.(self,g)
    ->(x) { g.(self.(x)) }
  end
  # Partial evaluation of a Proc (function)
  def partial(a)
    self.curry.(a)
  end
end
