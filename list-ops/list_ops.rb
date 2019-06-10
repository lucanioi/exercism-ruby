module ListOps
  module_function

  def arrays(array)
    counter = 0

    for element in array do
      counter += 1
    end

    counter
  end

  def reverser(array)
    reversed_array = []
    current_i = 0
    last_i = arrays(array) - 1

    for element in array do
      reversed_array[last_i - current_i] = element
      current_i += 1
    end

    reversed_array
  end

  def concatter(arr_1, arr_2)
    concat_array = arr_1.dup
    current_i = arrays(arr_1)

    for element in arr_2 do
      concat_array[current_i] = element
      current_i += 1
    end

    concat_array
  end

  def mapper(array)
    mapped_array = []
    current_i = 0

    for element in array do
      mapped_array[current_i] = yield(element)
      current_i += 1
    end

    mapped_array
  end

  def filterer(array)
    filtered_array = []
    current_i = 0

    for element in array do
      if yield(element)
        filtered_array[current_i] = element
        current_i += 1
      end
    end

    filtered_array
  end

  def sum_reducer(array)
    sum = 0

    for element in array do
      sum += element
    end

    sum
  end

  def factorial_reducer(array)
    product = 1

    for element in array do
      product *= element
    end

    product
  end
end
