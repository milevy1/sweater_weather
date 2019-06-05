class User < ApplicationRecord
  has_many :favorites
  has_secure_password

  def create_api_key
    self.api_key = SecureRandom.hex
    self.save
    api_key
  end
end
