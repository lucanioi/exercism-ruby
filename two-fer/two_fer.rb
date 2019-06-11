# frozen_string_literal: true

module TwoFer
  DEFAULT = 'you'
  TWO_FER = 'One for %s, one for me.'

  module_function

  def two_fer(name = DEFAULT)
    TWO_FER % name
  end
end
