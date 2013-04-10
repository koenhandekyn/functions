# reference http://iain.nl/going-crazy-with-to_proc

class Array
  # prepend element a to the array (self)
  def >> a
    self.unshift a
  end
end

class Array
  # converts the array into a Proc where
  # the first element is the method name, other elements are the values
  def to_proc
    head, *tail = *self
    Proc.new { |obj, *other| obj.__send__(head, *(other + tail)) }
  end
end

class Proc
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