class Array
  def accumulate(&blk)
    [].tap do |new_array|
      each do |e|
        new_array << blk.call(e)
      end
    end
  end
end
