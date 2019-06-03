class Anagram
  def initialize(target)
    @target = target
  end

  def match(str_array)
    str_array.select do |word|
      word.downcase != target.downcase &&
        process(word) == sorted_target
    end
  end

  private

  attr_reader :target

  def process(word)
    word.downcase.chars.sort
  end

  def sorted_target
    @sorted_target ||= process(target)
  end
end
