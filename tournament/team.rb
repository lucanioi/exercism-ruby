class Team
  attr_reader :name

  def initialize(name, matches)
    @name = name
    @matches = matches
  end

  def matches_played
    matches.count
  end

  def points
    wins * 3 + draws
  end

  def wins
    matches.count { |match| match.won?(self) }
  end

  def losses
    matches.count { |match| match.lost?(self) }
  end

  def draws
    matches.count(&:draw?)
  end

  private

  attr_reader :matches
end
