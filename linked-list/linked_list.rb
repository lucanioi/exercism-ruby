class Deque
  class Node
    attr_reader :value, :next, :prev

    def initialize(value)
      @value = value
      @next = nil
      @prev = nil
    end

    def unlink
      self.next&.prev = nil
      self.prev&.next = nil
      self.next = nil
      self.prev = nil
    end

    def link(other)
      self.next = other
      other.prev = self
    end

    protected

    attr_writer :next, :prev
  end

  def initialize
    @head = nil
    @tail = nil
  end

  def push(element)
    tap do
      node = Node.new(element)
      tail&.link(node)
      @head = node if empty?
      @tail = node
    end
  end

  def unshift(element)
    tap do
      node = Node.new(element)
      head && node.link(head)
      @tail = node if empty?
      @head = node
    end
  end

  def pop
    remove(tail, tail&.prev) do |new_tail|
      @head = nil unless new_tail
      @tail = new_tail
    end
  end

  def shift
    remove(head, head&.next) do |new_head|
      @tail = nil unless new_head
      @head = new_head
    end
  end

  private

  attr_reader :head, :tail

  def remove(node, replacement)
    return if empty?
    node.value.tap do
      node.unlink
      yield(replacement)
    end
  end

  def empty?
    !head && !tail
  end
end
