module Strain
  def keep
    return to_enum(:keep) unless block_given?
    each_with_object([]) do |element, result|
      result << element if yield(element)
    end
  end

  def discard
    return to_enum(:keep) unless block_given?
    each_with_object([]) do |element, result|
      result << element unless yield(element)
    end
  end
end

class Array
  include Strain
end
