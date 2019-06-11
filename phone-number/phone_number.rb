module PhoneNumber
  PHONE_REGEXP = /^(?:\+?1)?(\D*[2-9]\d{2}\D*[2-9]\d{2}\D*\d{4})$/

  module_function

  def clean(phone_number)
    if match = phone_number.strip.match(PHONE_REGEXP)
      match[1].scan(/\d/).join
    end
  end
end
