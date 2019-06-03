module Gigasecond
  GIGASECOND = 10**9

  module_function

  def from(second)
    second + GIGASECOND
  end
end
