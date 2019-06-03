class BinarySearch
  attr_reader :list

  def initialize(list)
    @list = list
    validate!
  end

  def search_for(number, arr = list, floor = 0, ceil = list.size - 1)
    mid = middle(arr)

    return floor + mid if arr[mid] == number
    raise RuntimeError if arr.size <= 1

    left, right = arr.each_slice(mid).to_a

    if number > arr[mid]
      search_for(number, right, floor + mid, ceil)
    else
      search_for(number, left, floor, floor + mid)
    end
  end

  private

  def middle(list)
    (list.size / 2.0).round
  end

  def validate!
    raise ArgumentError if list.sort != list
  end
end