class User < ActiveRecord::Base
  STATUS_INITIALIZED, STATUS_AVAILABLE, STATUS_PROHIBITED = 'initialized', 'available', 'prohibited'
  has_many :captchas
  has_many :tokens

  def approve!
    self.update_attribute(:status, STATUS_AVAILABLE) if self.status == STATUS_INITIALIZED
  end
  
  class << self
    def find_or_create phone
      self.where(phone: phone).first || self.create( { account: phone, phone: phone, status: STATUS_INITIALIZED } )
    end
  end
end