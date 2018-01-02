require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'pry'
class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    val = nil
    if @map[key]
      # binding.pry
      update_node!(@map[key])
      val = @map[key].val
    else 
      val = calc!(key)
    end 
    eject! if count > @max
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.append(key, @prc.call(key))
    @map[key] = @store.last
    @map[key].val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    # print to_s
    node.remove 
    @store.append(node.key, node.val)
    @map[node.key] = node 
    # print to_s
  end

  def eject!
    # p count
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
    # p count
  end
end

