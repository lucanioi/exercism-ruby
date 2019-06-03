class SecretHandshake
  HANDSHAKES = [
    [/1\z/,        ->(cmds) { cmds + ['wink'] }],
    [/1[10]\z/,    ->(cmds) { cmds + ['double blink'] }],
    [/1[10]{2}\z/, ->(cmds) { cmds + ['close your eyes'] }],
    [/1[10]{3}\z/, ->(cmds) { cmds + ['jump'] }],
    [/1[10]{4}\z/, ->(cmds) { cmds.reverse }],
  ].freeze

  def initialize(number)
    @number = number
  end

  def commands
    HANDSHAKES.reduce([]) do |cmds, (matcher, lam)|
      matcher.match?(binary) ? lam.call(cmds) : cmds
    end
  end

  private

  attr_reader :number

  def binary
    number.to_i.to_s(2)
  end
end
