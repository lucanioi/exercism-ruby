class Bst
  def initialize(data)
    @data = data
  end

  attr_reader :left, :right, :data

  def insert(new_data)
    new_data <= data ? insert_left(new_data) : insert_right(new_data)
  end

  def each(&blk)
    return to_enum unless block_given?

    tap do
      left.each(&blk) if left
      blk.call(data)
      right.each(&blk) if right
    end
  end

  private

  def insert_left(new_data)
    left ? left.insert(new_data) : @left = self.class.new(new_data)
  end

  def insert_right(new_data)
    right ? right.insert(new_data) : @right = self.class.new(new_data)
  end
end
