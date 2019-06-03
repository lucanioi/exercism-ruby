module PhoneNumber
  module_function

  PHONE_REGEXP = /^(?:\+?1)?(\D*[2-9]\d{2}\D*[2-9]\d{2}\D*\d{4})$/

  def clean(phone_number)
    return nil unless match = phone_number.strip.match(PHONE_REGEXP)

    match[1].scan(/\d/).join
  end
end

module BookKeeping
  VERSION = 2
end