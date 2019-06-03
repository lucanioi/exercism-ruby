module Hamming
  module_function

  def compute(strand1, strand2)
    raise ArgumentError unless strand1.size == strand2.size
    (0...strand1.size).count { |i| strand1[i] != strand2[i] }
  end
end
