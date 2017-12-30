class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    #Order matters 
    sum = 0
    self.each_with_index do |el, idx|
    sum += el * 2**idx if el.class == Fixnum 
    sum += el.ord * 2**idx if el.class == String
    end 
    sum.hash #hash function on fixnum. The sum should be good enough tbh, but may have collisions
  end 
end

class String
  def hash
    self.chars.hash 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    #stable order the keys 
    keys = self.keys 
    values = self.values
    keys.sort!
    values.sort!
    arr = keys.concat(values)
    arr.hash
  end
end
