class LessonsController < ApplicationController
    before_action :restrict_access, only: %i[create get_student_lessons get_tutor_lessons]
    before_action :only_students, only: %i[create]
    def create
        lesson = Lesson.new(user_id: @user.id, tutor_id: params[:tutor_id], day: params[:day], 
            begin_hour: params[:begin_hour], finish_hour: params[:finish_hour], subject_id: params[:subject_id], 
            city_id: @user.city_id)
        if lesson.valid?
            lesson.save
            #p lesson.tutor.name
            #lesson_helper = Lesson_helper.new(lesson)
            #p [lesson_helper].as_json
            render json: JSON[lesson_info(lesson)] , status: :created
            #render json: user.as_json(only: [:id, :email, :name, :remember_token]), status: :created
        else
            render json: lesson.errors.messages, status: :conflict
        end
    end

    def get_student_lessons
        lessons = @user.lessons
        lessons_helper = lessons.map{|le| lesson_info(le)}
        render json: lessons_helper, status: :ok
    end

    def get_tutor_lessons
        lessons = User.all.find(params[:tutor_id]).tutorLessons
        lessons_helper = lessons.map{|le| lesson_info(le)}
        render json: lessons_helper, status: :ok
    end
end
#, :user_name, :tutor_name, :day, :begin_hour, :finish_hour, :subject_name, :city_name

# ,
#         
#         } }