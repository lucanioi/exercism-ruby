class Allergies
  ALLERGENS = {
    eggs: 1,
    peanuts: 2,
    shellfish: 4,
    strawberries: 8,
    tomatoes: 16,
    chocolate: 32,
    pollen: 64,
    cats: 128
  }

  def initialize(score)
    @score = score
  end

  def list
    ALLERGENS.keys.select(&method(:allergic_to?)).map(&:to_s)
  end

  def allergic_to?(allergen)
    @score & ALLERGENS[allergen.to_sym] > 0
  end
end
