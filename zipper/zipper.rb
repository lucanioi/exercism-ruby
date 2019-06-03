Node = Struct.new(:value, :left, :right)

class Zipper
  class << self
    def from_tree(tree)
      new(tree, tree, [])
    end
  end

  def initialize(tree, focus, parents)
    @tree = tree
    @focus = focus
    @parents = parents
  end

  def left
    self.class.new(tree, focus.left, parents + [focus])
  end

  def right
    self.class.new(tree, focus.right, parents + [focus])
  end

  def up
    self.class.new(tree, parents.last, parents[0..-2])
  end

  def set_value(value)
    dup.tap { focus.value = value }
  end

  def set_left(node)
    dup.tap { focus.left = node }
  end

  def set_right(node)
    dup.tap { focus.right = node }
  end

  def to_tree
    tree
  end

  def value
    focus.value
  end

  def nil?
    focus.nil?
  end

  def ==(other)
    self.class == other.class &&
     tree == other.tree &&
     focus == other.focus &&
     parents == other.parents
  end

  protected

  attr_reader :tree, :focus, :parents
end
