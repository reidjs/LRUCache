require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  #loop over first half of string
  #store each char in map 
  #loop over second half and use quick lookup
  #if theres a missing char, return false 
  map = HashMap.new(string.length/2)
  i = 0
  while i < string.length/2
    map[string[i]] = true 
    i += 1
  end 
  i += 1 unless string % 2 == 0 #for odd chars, ignore middle char
  while i < string.length 
    return false if !map[string[i]]
    i += 1
  end 
  true 
end
