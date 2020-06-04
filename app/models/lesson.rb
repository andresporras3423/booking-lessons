class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :city
    belongs_to :user
    belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
    belongs_to :subject
    validate :no_overlap_tutor_lesson, :no_overlap_student_lesson
    validate :tutor_is_tutor, :student_tutor_different_users, :is_tutor_subject, :is_future_date
    
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

    def tutor_is_tutor
        if User.all.find(tutor_id).role_id != Role.find_by_name("tutor").id
            errors.add(:base, message: "tutor must be the tutor's role")
        end
    end

    def is_future_date
        if day<Date.today
            errors.add(:base, message: "lesson must occur in the future")
        end
    end

    def no_overlap_tutor_lesson
        throw_error = User.all.find(tutor_id).tutorLessons.any?{|le| le.day.to_date == day.to_date && ((le.begin_hour>=begin_hour && le.begin_hour<finish_hour) || (le.finish_hour<=finish_hour && le.finish_hour>begin_hour))}
        #p "passed validation was #{throw_error}"
        if throw_error
            errors.add(:base, message: "lesson cannot overlap with another tutor's lesson")
        end
    end

    def no_overlap_student_lesson
        throw_error = User.all.find(user_id).lessons.any?{|le| le.day.to_date == day.to_date && ((le.begin_hour>=begin_hour && le.begin_hour<finish_hour) || (le.finish_hour<=finish_hour && le.finish_hour>begin_hour))}
        #p "passed validation was #{throw_error}"
        if throw_error
            errors.add(:base, message: "lesson cannot overlap with another students's lesson")
        end
    end
end
