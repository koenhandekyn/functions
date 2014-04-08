class Hash

  def zip_hash_left(bs)
    self.each_with_object({}) { |(k, a), h| h[k] = [a, bs[k]]; h }
  end

  def zip_hash_inner(bs)
    self.each_with_object({}) { |(k, a), h| b = bs[k]; h[k] = [a, b] if b; h }
  end

  def map_values 
    Hash[self.map{|k, v| [k, yield(v)] }]
  end

  def map_values_recurse(&b)
    Hash[self.map{|k, v| [k, v.is_a?(Hash) ? v.map_values_recurse(&b) : b.(v)] }]
  end

  # TODO discuss if we should not map onto array as values can colide
  def map_keys
    Hash[self.map{|k, v| [yield(k), v] }]
  end

  def map_keys_recurse(&b)
    Hash[self.map{|k, v| [b.(k), v.is_a?(Hash) ? v.map_keys_recurse(&b) : v ] }]
  end

  # map a hash into a hash
  def map_hash 
    Hash[ self.map{|k, v| yield(k,v) } ]
  end

  # map a hash into a hash recursively. 
  # the mapping function needs to check itself wether or not the value is hash and act appropriately 
  def map_recurse(&b)
    Hash[ self.map{|k, v| b.(k, v.is_a?(Hash) ? v.map_recurse(&b) : v) } ]
  end

  # map a hash into a hash recursively with a seperate key mapping and value mapping function
  def map_keys_and_values(km, vm)
    Hash[ self.map{|k, v| [ km.(k), v.is_a?(Hash) ? v.map_keys_and_values(km, vm) : vm.(v) ] } ]
  end

  # map a hash into a hash recursively where one key value mapping can be mapped onto multi key value mappings
  def multi_map(&b)
    Hash[ self.map{|k, v| b.(k, ( v.is_a?(Hash) ? v.multi_map(&b) : v) ) }.flatten(1) ]
  end

   # def map_hash &blk
   #   res = {}
   #   each do |k,v|
   #     kk, vv = blk.call(k,v)
   #     res[kk] = vv
   #   end
   #   res
   # end

end

