class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :city
    belongs_to :user
    belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
    belongs_to :subject
    validate :student_tutor_different_users
    
    private
    def student_tutor_different_users
        p "SUCH A WONDERFUL WORLD"
        if user_id==tutor_id
            errors.add(:base, message: "student and tutor cannot be the same person")
          end
    end
end
