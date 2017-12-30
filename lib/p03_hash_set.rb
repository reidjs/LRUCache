require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    @count += 1
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    buffer = num_buckets * 2
    temp_store = Array.new(buffer) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        temp_store[el.hash % num_buckets] << el
      end 
    end 
    @store = temp_store
  end
end
