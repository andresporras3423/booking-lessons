class User < ApplicationRecord
    has_secure_password

    validates :email, uniqueness: true
  
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    def authenticated?(remember_token)
      self.remember_token == remember_token
    end
  
    def record_signup
      token = SecureRandom.urlsafe_base64
      crypt_token = Digest::SHA1.hexdigest token.to_s
      self.remember_token = crypt_token
    end
  end
  