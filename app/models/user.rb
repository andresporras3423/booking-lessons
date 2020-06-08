class User < ApplicationRecord
    has_secure_password
    belongs_to :role
    belongs_to :city
    has_many :userSubjects
    has_many :subjects, :through => :userSubjects
    has_many :lessons
    has_many :tutorLessons
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, length: { minimum:4}
    validates :name, length: { minimum:1}

    def tutorLessons
      Lesson.all.select{|le| le.tutor_id==self.id}
    end
  
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
  