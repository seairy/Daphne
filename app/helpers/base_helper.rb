module BaseHelper extend self

  def is_phone? phone
    if phone.blank?
      false
    elsif not phone =~ /^\d{11}$/
      false
    else
      true
    end
  end

  def is_captcha? captcha
    if captcha.blank?
      false
    elsif not captcha =~ /^\d{6}$/
      false
    else
      true
    end
  end
end