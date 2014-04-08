require_relative '../lib/functions'

folders = {
  'main[2]' => { 'child[3]' => 'leaf'}
}

def multiply_folder(k,v)
  match = k.match(/(.*)\[(\d+)\]/)
  k, count = match ? [match[1], match[2].to_i] : [k, nil]
  if count
    (1..count).map { |i| ["#{k}_#{i}",v] }
  else
    [[k,v]]
  end
end

multiplied = folders.multi_map_hash_recursive &multiply_folder

puts multiplied