require 'set'

class BookStore
  UNIT_PRICE = 8
  BOOKS = [1, 2, 3, 4, 5].freeze
  DISCOUNTS = [0, 0, 0.05, 0.1, 0.2, 0.25].freeze

  class << self
    def calculate_price(basket)
      new.calculate_price(basket)
    end

    private :new
  end

  def calculate_price(basket)
    return prices[basket] if prices[basket]
    prices[basket] = discount_sets(basket).map do |set|
      rest = subtract(basket, set)
      price_for_set(set) + calculate_price(rest)
    end.min
  end

  private

  def prices
    @prices ||= { [] => 0 }
  end

  def discount_sets(basket)
    (1...DISCOUNTS.size).flat_map do |set_size|
      BOOKS.to_a.combination(set_size)
        .select { |set| subset?(basket, set) }
    end
  end

  def price_for_set(set)
    set.size * (UNIT_PRICE * (1 - DISCOUNTS[set.size]))
  end

  def subtract(basket, set)
    basket.dup.tap do |basket|
      (basket & set).each do |book|
        basket.delete_at(basket.index(book))
      end
    end
  end

  def subset?(set, subset)
    (set & subset).size == subset.size
  end
end
