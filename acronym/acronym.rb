module Acronym
  module_function

  def abbreviate(string)
    string.scan(/[A-Za-z']+/).map(&:chr).join.upcase
  end
end
