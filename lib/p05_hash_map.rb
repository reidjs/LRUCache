require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'pry'
class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if get(key).nil?
    true 
  end

  def set(key, val)
    list = @store[bucket(key)]
    if get(key).nil?
      resize! if count >= @store.length 
      list.append(key, val)
      @count += 1
    else 
      list.update(key, val)
    end 
  end

  def get(key)
    # @store[key.hash % num_buckets]
    @store[bucket(key)].get(key)
    # binding.pry
  end

  def get_list(key)
    @store[bucket(key)]
  end 

  def delete(key)
    if include?(key)
      get_list(key).remove(key) 
      @count -= 1
    end 
  end

  def each
    @store.each do |list|
        list.each do |node|
          yield [node.key, node.val] 
          # binding.pry
        end 
    end 
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # temp_store = Array.new(num_buckets * 2) { LinkedList.new }
    new_hash = HashMap.new(num_buckets * 2)
    @store.each do |list|
      list.each do |node|
        new_hash.set(node.key, node.val)
      end 
    end 
    @store = new_hash.store 
    # @store.each_with_index do |list|
    #   list.each do |node|

    #   end 
    # end 
    # @store = temp_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
