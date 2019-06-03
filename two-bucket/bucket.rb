class Bucket
  attr_reader :name, :content

  class << self
    def pour(from:, to:)
      delta = [to.space_left, from.content].min
      [from.empty(delta), to.fill(delta)]
    end
  end

  def initialize(name, size, content = 0)
    @name = name
    @size = size
    @content = content
  end

  def fill(amount = size)
    self.class.new(name, size, [size, content + amount].min)
  end

  def empty(amount = content)
    self.class.new(name, size, [0, content - amount].max)
  end

  def empty?
    content.zero?
  end

  def full?
    size == content
  end

  def space_left
    size - content
  end

  private

  attr_reader :size
end
