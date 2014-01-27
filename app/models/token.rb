require 'digest/md5'

class Token < ActiveRecord::Base
  belongs_to :user
  scope :available, -> { where(available: true) }

  class << self
    def generate_for user
      salt = "#{user.phone}-#{Time.now}-#{Random.new.rand}"
      self.where(user_id: user.id).update_all available: false 
      self.create({ user: user, content: Digest::MD5.hexdigest(salt) })
    end
  end
end