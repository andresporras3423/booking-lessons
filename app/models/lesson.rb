class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :city
    belongs_to :user
    belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
    belongs_to :subject
    validate :student_tutor_different_users, :is_tutor_subject
    
    private
    def student_tutor_different_users
        if user_id==tutor_id
            errors.add(:base, message: "student and tutor cannot be the same person")
          end
    end

    def is_tutor_subject
        if User.all.find(tutor_id).userSubjects.none?{|us| us.subject_id==subject_id}
            errors.add(:base, message: "subject must be a tutor subject")
          end
    end
end
