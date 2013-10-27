module Enumerable

  def zip_map *lists, &b
    self.zip(*lists).map(&b)
  end

  # TODO study to understand
  def transpose
    self.with_index do |i| 
      yield self.with_object(i).map &:[]
    end
  end  

  # splits a list xs in n peices
  def split_in(n) 
    (split = self.each_slice((self.length+1)/n).to_a).concat [[]] * (n-split.length)
  end

  def split_in_half 
    split_in(2)
  end

  def counted_set 
    self.inject( Hash.new(0) ) { |h,e| h[e] += 1; h } 
  end


  # merges two ordered lists by a function f that compares the values
  # if no function is given the values are compared by the "<" operator
  def merge ys, &f

    return self.dup if ys.empty?
    return ys.dup if self.empty?

    x, *xt = self
    y, *yt = ys

    return ys.merge(xt, &f) >> x if f.nil? ? x <= y : yield(x) <= yield(y)
    return xs.merge(yt, &f) >> y

  end

end