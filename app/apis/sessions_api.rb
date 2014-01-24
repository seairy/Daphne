class SessionsApi < BaseApi

  get '/captcha' do
    unless BaseHelper.is_phone? params[:phone]
      json Result::Failure.create(20101)
    else
      json Result::Success.create(Captcha.generate_for(User.find_or_create(params[:phone])).content)
    end
  end
  
  get '/signin' do
    if not BaseHelper.is_phone? params[:phone]
      json Result::Failure.create(20101)
    elsif not BaseHelper.is_captcha? params[:captcha]
      json Result::Failure.create(20102)
    else
      user = User.where(phone: params[:phone]).first
      if user.blank?
        json Result::Failure.create(20103)
      else
        captcha = Captcha.where(content: params[:captcha]).first
        if captcha.blank?
          json Result::Failure.create(20104)
        else
          if captcha.expired_at < Time.now.utc
            json Result::Failure.create(20105)
          elsif not captcha.user_id == user.id
            json Result::Failure.create(20104)
          elsif not captcha.available?
            json Result::Failure.create(20105)
          else
            captcha.expire!
            json Result::Success.create(Token.generate_for(user).content)
          end
        end
      end
    end
  end
end