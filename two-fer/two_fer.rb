# frozen_string_literal: true

module TwoFer
  module_function

  DEFAULT = 'you'
  TWO_FER = 'One for %s, one for me.'

  def two_fer(name = DEFAULT)
    TWO_FER % name
  end
end
