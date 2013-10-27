class Hash

  def zip_hash_left(bs)
    self.each_with_object({}) { |(k, a), h| h[k] = [a, bs[k]]; h }
  end

  def zip_hash_inner(bs)
    self.each_with_object({}) { |(k, a), h| b = bs[k]; h[k] = [a, b] if b; h }
  end

  def map_hash 
    Hash[self.map{|k, v| [k, yield(v)] }]
  end


end