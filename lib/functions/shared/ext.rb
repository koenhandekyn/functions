class Array
  # prepend element a to the array (self)
  def >> a
    self.unshift a
  end
end

module Kernel

  def tailrecurse(&b)
    result = []
    loop do
      result = b.(*result)
    end
  end

end