module Isogram
  ALPHABET = /[a-z]/

  module_function

  def isogram?(input)
    input.downcase.scan(ALPHABET).then do |chars|
      chars.uniq.size == chars.size
    end
  end
end
