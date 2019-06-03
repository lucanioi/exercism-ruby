module ScoreBoard
  TEMPLATE = '%-31s| %2s | %2s | %2s | %2s | %2s'.freeze
  HEADERS = %w[Team MP W D L P].freeze

  class << self
    def format_results(teams)
      [
        headers,
        team_results(teams)
      ].reject(&:empty?).join("\n") + "\n"
    end

    private

    def headers
      TEMPLATE % HEADERS
    end

    def team_results(teams)
      teams.sort_by { |t| [-t.points, t.name] }
        .map(&method(:team_result))
        .join("\n")
    end

    def team_result(team)
      TEMPLATE % [
        team.name,
        team.matches_played,
        team.wins,
        team.draws,
        team.losses,
        team.points
      ]
    end
  end
end
