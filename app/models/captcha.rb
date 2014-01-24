class Captcha < ActiveRecord::Base
  OPERATION_SIGNIN = 'signin'
  belongs_to :user

  def expire!
    self.update_attribute :available, false
  end

  class << self
    def generate_for user
      self.create( { user: user, content: Random.new.rand(123456..987654), operation: OPERATION_SIGNIN, expired_at: Time.now + 15.minutes } )
    end
  end
end