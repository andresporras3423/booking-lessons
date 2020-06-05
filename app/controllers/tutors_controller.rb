class TutorsController < ApplicationController
    before_action :restrict_access, only: %i[show_past_lessons show_today_lessons show_future_lessons]

    def show_past_lessons
        lessons = @user.tutorLessons
        lessons_helper = lessons.select{|le| le.day<Date.today}
        render json: lessons_helper, status: :ok
    end

    def show_today_lessons
        lessons = @user.tutorLessons
        lessons_helper = lessons.select{|le| le.day==Date.today}
        render json: lessons_helper, status: :ok
    end

    def show_future_lessons
        lessons = @user.tutorLessons
        lessons_helper = lessons.select{|le| le.day>Date.today}
        render json: lessons_helper, status: :ok
    end
end
