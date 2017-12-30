class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next 
    @next.prev = @prev
  end
end

class LinkedList
  def initialize
    @head = Node.new 
    @tail = Node.new 
    @tail.prev = @head 
    @head.next = @tail
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = first 
    while node 
      return node.val if node.key == key
      node = node.next 
    end 
    nil
  end 

  def find(key)
    i = 0
    node = first 
    while node
      return node if node.key == key
      node = node.next 
    end 
    nil
  end

  def include?(key)
  end

  def append(key, val)
    node = Node.new(key, val)
    temp_node = last
    @tail.prev = node 
    # last = node 
    node.next = @tail 
    temp_node.next = node 
    node.prev = temp_node 
  end

  def update(key, val)
    node = find(key)
    node.val = val if node 
  end

  def remove(key)
    node = find(key)
    node.remove
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
