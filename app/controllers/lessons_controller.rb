class LessonsController < ApplicationController
    before_action :restrict_access, only: %i[create update get_student_lessons get_tutor_lessons delete]
    before_action :only_students, only: %i[create update]
    def create
        lesson = Lesson.new(user_id: @user.id, tutor_id: params[:tutor_id], day: params[:day], 
            begin_hour: params[:begin_hour], finish_hour: params[:finish_hour], subject_id: params[:subject_id], 
            city_id: @user.city_id)
        if lesson.valid?
            lesson.save
            
            render json: JSON[lesson_info(lesson)] , status: :created
        else
            render json: lesson.errors.messages, status: :conflict
        end
    end

    def update
        begin
            lesson = Lesson.all.find(params[:lesson_id])
            if lesson.day<=Date.today
                render json: JSON[{"error": "you can't edit past or today lessons"}], status: :forbidden
            elsif lesson.user_id!=@user.id && @user.role_id!=Role.all.find_by_name("administrator").id
                render json: JSON[{"error": "you are not authorized to do this action"}], status: :unauthorized
            else
                lesson.tutor_id = params[:tutor_id].nil? ? lesson.tutor_id : params[:tutor_id]
                lesson.day = params[:day].nil? ? lesson.day : params[:day]
                lesson.begin_hour = params[:begin_hour].nil? ? lesson.begin_hour : params[:begin_hour]
                lesson.finish_hour = params[:finish_hour].nil? ? lesson.finish_hour : params[:finish_hour]
                lesson.subject_id = params[:subject_id].nil? ? lesson.subject_id : params[:subject_id]
                lesson.city_id = @user.city_id
                if lesson.valid?
                    lesson.save
                    render json: JSON[lesson_info(lesson)] , status: :accepted
                else
                    render json: lesson.errors.messages, status: :conflict
                end
            end
        rescue StandardError => e
            render json: JSON[{"error": "lesson doesn't exist"}], status: :not_found
        end
    end

    def delete
        begin
            lesson = Lesson.all.find(params[:lesson_id])
            if lesson.day<=Date.today
                render json: JSON[{"error": "you can't delete past or today lessons"}], status: :forbidden
            elsif lesson.user_id!=@user.id && lesson.tutor_id!=@user.id && @user.role_id!=Role.all.find_by_name("administrator").id
                render json: JSON[{"error": "you are not authorized to do this action"}], status: :unauthorized
            else
                lesson.destroy
                render json: JSON[{"status": "accepted"}], status: :created
            end
        rescue StandardError => e
            render json: JSON[{"error": "lesson doesn't exist"}], status: :not_found
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