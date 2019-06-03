require_relative 'match'
require_relative 'team'
require_relative 'score_board'

class Tournament
  class << self
    def tally(matches)
      new(matches).tally
    end

    private :new
  end

  def initialize(string)
    @matches = create_matches(string.strip)
    @teams = create_teams
  end

  def tally
    ScoreBoard.format_results(teams)
  end

  private

  attr_reader :matches, :teams

  def create_matches(string)
    string.lines.map do |match_result|
      Match.from_string(match_result)
    end
  end

  def create_teams
    all_team_names.map do |name|
      Team.new(name, matches_with(name))
    end
  end

  def all_team_names
    matches.flat_map(&:teams).uniq
  end

  def matches_with(team_name)
    matches.select do |m|
      m.teams.include?(team_name)
    end
  end
end
