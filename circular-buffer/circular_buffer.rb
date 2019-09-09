class CircularBuffer
  BufferEmptyException = Class.new StandardError
  BufferFullException = Class.new StandardError

  def initialize(num_slots)
    @num_slots = num_slots
    @buffer = []
  end

  def read
    buffer_empty! if buffer.empty?
    buffer.pop
  end

  def write(data)
    buffer_full! if buffer_full?
    buffer.unshift(data)
  end

  def write!(data)
    buffer.pop if buffer_full?
    buffer.unshift(data)
  end

  def clear
    @buffer = []
  end

  private

  attr_reader :num_slots, :buffer

  def buffer_empty!
    raise BufferEmptyException
  end

  def buffer_full!
    raise BufferFullException
  end

  def buffer_full?
    buffer.size >= num_slots
  end
end