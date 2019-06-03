module Bob
  SHOUTING = /^(?!.*[a-z]).*[A-Z]+/
  SHOUTING_QUESTION = /#{SHOUTING}.*\?\z/
  QUESTION = /\?\z/
  SILENCE = /\A[\s\t\r\n\f]+\z/

  module_function

  def hey(remark)
    case remark.strip
    when SHOUTING_QUESTION then 'Calm down, I know what I\'m doing!'
    when SHOUTING then'Whoa, chill out!'
    when QUESTION then'Sure.'
    when '' then 'Fine. Be that way!'
    else 'Whatever.'
    end
  end
end
