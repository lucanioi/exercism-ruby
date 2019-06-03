class Diamond
  LETTERS = ('A'..'Z').to_a

  class << self
    def make_diamond(center_letter)
      new(center_letter).make
    end

    private :new
  end

  def initialize(center_letter)
    @center_letter = center_letter
  end

  def make
    if single_line?
      edge + "\n"
    else
      edge + "\n" + body + "\n" + edge + "\n"
    end
  end

  private

  attr_reader :center_letter

  def single_line?
    center_letter == LETTERS.first
  end

  def edge
    outer_spaces(0) + LETTERS.first + outer_spaces(0)
  end

  def body
    body_levels.map do |level|
      left_half = outer_spaces(level) + letter_at(level)
      left_half + inner_spaces(level) + left_half.reverse
    end.join("\n")
  end

  def body_levels
    (1..center_index).to_a + (1...center_index).to_a.reverse
  end

  def outer_spaces(level)
    spaces(center_index - level)
  end

  def inner_spaces(level)
    spaces((level - 1) * 2 + 1)
  end

  def spaces(count)
    ' ' * count
  end

  def center_index
    LETTERS.index(center_letter)
  end

  def letter_at(index)
    LETTERS[index]
  end
end
