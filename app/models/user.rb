class User < ApplicationRecord
  has_secure_password

  def create_api_key
    self.api_key = SecureRandom.hex
  end
end
