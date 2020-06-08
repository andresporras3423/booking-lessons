class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :city
    belongs_to :user
    belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
    belongs_to :subject
    validate :student_is_student, :tutor_is_tutor, :student_tutor_different_users, :is_tutor_subject, :no_overlap_tutor_lesson, :no_overlap_student_lesson, :valid_begin_hour, :valid_finish_hour, :finish_after_begin
    
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
        tutor = User.all.find(tutor_id)
        return if tutor.nil?
        if tutor.role_id != Role.find_by_name("tutor").id
            errors.add(:base, message: "tutor must be the tutor's role")
        end
    end

    def student_is_student
        if User.all.find(user_id).role_id != Role.find_by_name("student").id
            errors.add(:base, message: "student must be the tutor's role")
        end
    end

    # def is_future_date
    #     if day<Date.today
    #         errors.add(:base, message: "lesson must occur in the future")
    #     end
    # end

    def no_overlap_tutor_lesson
        tutor = User.all.find(tutor_id)
        return if tutor.nil?
        throw_error = tutor.tutorLessons.any?{|le| le.day.to_date == day.to_date && ((le.begin_hour>=begin_hour && le.begin_hour<finish_hour) || (le.finish_hour<=finish_hour && le.finish_hour>begin_hour)) && le.id!=id}
        #p "passed validation was #{throw_error}"
        if throw_error
            errors.add(:base, message: "lesson cannot overlap with another tutor's lesson")
        end
    end

    def no_overlap_student_lesson
        student = User.all.find(user_id)
        return if student.nil?
        throw_error = student.lessons.any?{|le| le.day.to_date == day.to_date && ((le.begin_hour>=begin_hour && le.begin_hour<finish_hour) || (le.finish_hour<=finish_hour && le.finish_hour>begin_hour))  && le.id!=id}
        #p "passed validation was #{throw_error}"
        if throw_error
            errors.add(:base, message: "lesson cannot overlap with another students's lesson")
        end
    end

    def valid_begin_hour
        if begin_hour<0 || begin_hour>23
            errors.add(:begin_hour, message: "begin hour must be a number between 0 and 23")
        end
    end

    def valid_finish_hour
        if finish_hour<1 || finish_hour>24
            errors.add(:finish_hour, message: "finish hour must be a number between 1 and 24")
        end
    end

    def finish_after_begin
        if finish_hour<=begin_hour
            errors.add(:base, message: "finish hour must be bigger than begin hour")
        end
    end
end