class CustomSet
  def initialize(array)
    @lookup_hash = hashify(array)
  end

  def empty?
    elements.empty?
  end

  def member?(element)
    lookup_hash[element]
  end

  def subset?(other)
    elements.all? { |e| other.member? e }
  end

  def disjoint?(other)
    elements.none? { |e| other.member? e }
  end

  def add(element)
    tap { lookup_hash[element] = true }
  end

  def intersection(other)
    new_set(elements.select { |e| other.member? e })
  end

  def union(other)
    new_set(elements + other.elements)
  end

  def difference(other)
    new_set(elements.reject { |e| other.member? e })
  end

  def ==(other)
    elements.size == other.elements.size && subset?(other)
  end

  def inspect
    "#<CustomSet: #{elements}>"
  end

  def to_s
    "#<CustomSet:#{object_id}>"
  end

  protected

  def elements
    lookup_hash.keys
  end

  private

  attr_reader :lookup_hash

  def new_set(array)
    self.class.new(array)
  end

  def hashify(elements)
    elements.reduce(Hash.new(false)) do |set, element|
      set.merge(element => true)
    end
  end
end
