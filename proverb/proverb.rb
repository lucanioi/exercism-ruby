class Proverb
  def initialize(*words, qualifier: nil)
    @words     = words.freeze
    @qualifier = qualifier.freeze
  end

  def to_s
    @proverb ||= concoct_proverb
  end

  private

  attr_reader :words

  def concoct_proverb
    (words.each_cons(2).map(&method(:refrain)) << last_line).join("\n")
  end

  def refrain((part, whole))
    "For want of a #{part} the #{whole} was lost."
  end

  def last_line
    "And all for the want of a #{qualifier}#{words.first}."
  end

  def qualifier
    @qualifier + "\s" if @qualifier
  end
end
