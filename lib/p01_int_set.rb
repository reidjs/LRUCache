# We'll start with the first stage. In this version of a set, we can only
# store integers that live in a predefined range. So I tell you the
# maximum integer I'll ever want to store, and you give me a set that can
# store it and any smaller positive number.

# - Initialize your MaxIntSet with an integer called `max` to define the
#   range of integers that we're keeping track of.
# - Internal structure:
#   - An array called `@store`, of length `max`
#   - Each index in the `@store` will correspond to an item, and the value
#     at that index will correspond to its presence (either `true` or
#     `false`)
#   - e.g., the set `{ 0, 2, 3 }` will be stored as: `[true, false, true,
#     true]`
#   - The size of the array will remain constant!
#   - The `MaxIntSet` should raise an error if someone tries to insert, remove, or check inclusion of a number that is out of bounds.
# - Methods:
#   - `#insert`
#   - `#remove`
#   - `#include?`

# Once you've built this and it works, we'll move on to the next
# iteration.
require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def length 
    @store.length
  end 

  def insert(num)
    raise "Out of bounds" if num < 0 || num >= length
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num]
    false 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return true if self[num].include?(num)
    false 
  end

  private

  def [](num)
    @store[num % @buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= num_buckets
    self[num] << num
    @count += 1
    # debugger if @count >= 20
  end
  #should raise error if number not in array 
  def remove(num)
    @count -= 1
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    temp_num_buckets = num_buckets * 2
    temp_store = Array.new(temp_num_buckets) { Array.new }
    #Warning: O(n^2) operation below!
    @store.each do |bucket|
      bucket.each do |num|
        temp_store[num % temp_num_buckets] = self[num]
      end 
    end 
    @store = temp_store
  end
end

# x = ResizingIntSet.new 
# 20.times do |i|
#   x.insert(i)
# end 
# p x 
# x.insert(20)
# p x
# x.insert(21)
# p x

# set = ResizingIntSet.new(20)
# elements = (10..30).to_a
# elements.each { |el| set.insert(el) }
# p set
# elements.each do |el|
#   p el 
#   p set.include?(el)
# end