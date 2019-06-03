class Change
  NegativeTargetError = Class.new(StandardError)
  ImpossibleCombinationError = Class.new(StandardError)

  class << self
    def generate(coins, total)
      new(coins, total).optimal_change
    end

    private :new
  end

  def initialize(coins, total)
    raise NegativeTargetError if total < 0
    @coins = coins
    @total = total
    generate!
  end

  def optimal_change
    table[total]&.sort
  end

  private

  attr_reader :coins, :total

  def generate!
    coins.sort.reverse.each(&method(:all_optimal_change))
    raise ImpossibleCombinationError unless optimal_change
  end

  def all_optimal_change(coin)
    (coin..total).each(&method(:map_optimal_change).curry[coin])
  end

  def map_optimal_change(coin, subtotal)
    return unless partial_change = table[subtotal - coin]
    change = partial_change + [coin]
    table[subtotal] = change if optimal_change?(change)
  end

  def optimal_change?(change)
    !((current = table[change.sum]) && current.size < change.size)
  end

  def table
    @table ||= [[]]
  end
end
