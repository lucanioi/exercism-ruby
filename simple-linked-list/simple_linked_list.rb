class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
  end

  def ==(other)
    self.class == other.class &&
      datum == other.datum
  end
end

class SimpleLinkedList
  def initialize(array = [])
    @head = to_linked_list(array)
  end

  def push(element)
    tap do
      element.next = head
      @head = element
    end
  end

  def pop
    head.tap do |element|
      @head = element&.next
      element&.next = nil
    end
  end

  def to_a
    return [] unless head
    [head.datum].tap do |arr|
      elem = head
      while elem = elem&.next
        arr << elem.datum
      end
    end
  end

  def reverse!
    tap { @head = to_linked_list(to_a) }
  end

  private

  attr_reader :head

  def to_linked_list(array)
    array
      .map { |elem| Element.new(elem) }
      .reduce { |head, current| current.tap { |c| c.next = head } }
  end
end
