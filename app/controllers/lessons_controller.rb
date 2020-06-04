class LessonsController < ApplicationController
    before_action :restrict_access, only: %i[create]
    def create
        lesson = Lesson.create(user_id: @user.id, tutor_id: params[:tutor_id], day: params[:day], 
            begin_hour: params[:begin_hour], finish_hour: params[:finish_hour], subject_id: params[:subject_id], 
            city_id: @user.city_id)
        if lesson.valid?
            lesson.save
            #p lesson.tutor.name
            lesson_helper = Lesson_helper.new(lesson)
            #p [lesson_helper].as_json
            render json: JSON[{"lesson_id": lesson_helper.lesson_id, "tutor": lesson_helper.tutor_name, "student": lesson_helper.user_name,
                "day": lesson_helper.day, "begin_hour": lesson_helper.begin_hour, "finish_hour": lesson_helper.finish_hour,
                "subject": lesson_helper.subject_name, "city": lesson_helper.city_name}] , status: :created
            #render json: user.as_json(only: [:id, :email, :name, :remember_token]), status: :created
        else
            render json: lesson.errors.messages, status: :conflict
        end
    end
end
#, :user_name, :tutor_name, :day, :begin_hour, :finish_hour, :subject_name, :city_name