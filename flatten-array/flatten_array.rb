module FlattenArray
   module_function

  def flatten(array)
    head, *tail = array
    case head
    when Array then flatten(head) + flatten(tail)
    when nil then array.empty? ? [] : flatten(tail)
    else [head] + flatten(tail)
    end
  end
end
