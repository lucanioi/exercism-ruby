class ComplexNumber
  attr_reader :real, :imag

  alias_method :imaginary, :imag

  def initialize(real, imag)
    @real = real
    @imag = imag
  end

  def *(other)
    build do |c|
      c.real = real * other.real - imag * other.imag
      c.imag = imag * other.real + real * other.imag
    end
  end

  def +(other)
    build do |c|
      c.real = real + other.real
      c.imag = imag + other.imag
    end
  end

  def -(other)
    build do |c|
      c.real = real - other.real
      c.imag = imag - other.imag
    end
  end

  def /(other)
    build do |c|
      c.real = (real * other.real + imag * other.imag).to_f
                 ./ (other.real**2 + other.imag**2)
      c.imag = (imag * other.real - real * other.imag).to_f
                 ./ (other.real**2 + other.imag**2)
    end
  end

  def abs
    Math.sqrt(real**2 + imag**2)
  end

  def conjugate
    build do |c|
      c.real = real
      c.imag = -imag
    end
  end

  def exp
    first_term = build do |c|
      c.real = Math.exp(real)
      c.imag = 0
    end

    last_term = build do |c|
      c.real = Math.cos(imag)
      c.imag = Math.sin(imag).round
    end

    first_term * last_term
  end

  def ==(other)
    real == other.real && imag == other.imag
  end

  private

  Proxy = Struct.new(:real, :imag)

  def build(&blk)
    proxy = Proxy.new.tap { |px| blk.call(px) }
    self.class.new(proxy.real, proxy.imag)
  end
end
