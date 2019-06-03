# frozen_string_literal: true

class Match
  class << self
    def from_string(string)
      new(*string.strip.split(';'))
    end
  end

  def initialize(team_1, team_2, result)
    @team_1 = team_1
    @team_2 = team_2
    @result = result
  end

  def won?(team)
    winner == team.name
  end

  def lost?(team)
    loser == team.name
  end

  def draw?
    result == 'draw'
  end

  def played?(team)
    teams.include? team.name
  end

  def teams
    [team_1, team_2]
  end

  private

  attr_reader :team_1, :team_2, :result

  def winner
    case result
    when 'win' then team_1
    when 'loss' then team_2
    end
  end

  def loser
    case result
    when 'win' then team_2
    when 'loss' then team_1
    end
  end
end
