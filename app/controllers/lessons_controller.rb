class LessonsController < ApplicationController
    before_action :restrict_access, only: %i[create update get_student_lessons get_tutor_lessons delete]
    before_action :only_students, only: %i[create update]

    #create for the current user (it has to be a student role)
    #
    # == HTTP_METHOD:
    #   POST
    # == Route:
    # /lessons/create
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # tutor_id:
    #   id of lesson's tutor
    # day:
    #   date of the lesson
    # begin_hour:
    #   begin hour of the lesson
    # finish_hour:
    #   finish hour of the lesson
    # subject_id:
    #   id of the lesson's subject. It has to be one of the tutor's subjects.
    # == Response:
    # render::
    #   Message of status accepted
    # status::
    #   accepted
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

    #update a lesson of the current user (user has to be the lesson student or administrador role)
    #
    # == HTTP_METHOD:
    #   PUT
    # == Route:
    # /lessons/update
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # lesson_id:
    #   id of the lesson to update
    # tutor_id:
    #   id of the new tutor
    # day:
    #   new day
    # begin_hour:
    #   new begin hour
    # finish_hour:
    #   new finish hour
    # subject_id:
    #   id of the new lesson subject
    # == Response:
    # render::
    #   Message of status accepted
    # status::
    #   accepted
    def update
        begin
            lesson = Lesson.all.find(params[:lesson_id])
            if lesson.day<=Date.today
                render json: JSON[{"error": "you can't edit past or today lessons"}], status: :forbidden
            elsif lesson.user_id!=@user.id && @user.role_id!=Role.all.find_by_name("administrator").id
                render json: JSON[{"error": "you are not authorized to do this action"}], status: :unauthorized
            else
                lesson.tutor_id = params[:tutor_id].nil? ? lesson.tutor_id : params[:tutor_id].to_i
                lesson.day = params[:day].nil? ? lesson.day : params[:day].to_i
                lesson.begin_hour = params[:begin_hour].nil? ? lesson.begin_hour : params[:begin_hour].to_i
                lesson.finish_hour = params[:finish_hour].nil? ? lesson.finish_hour : params[:finish_hour].to_i
                lesson.subject_id = params[:subject_id].nil? ? lesson.subject_id : params[:subject_id].to_i
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

    #destroy a lesson of the current user (yuser has to be the lesson student, or the lesson tutor or administrator role)
    #
    # == HTTP_METHOD:
    #   DELETE
    # == Route:
    # /lessons/delete
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # lesson_id:
    #   id of the lesson to delete
    # == Response:
    # render::
    #   Message of status accepted
    # status::
    #   accepted
    def delete
        begin
            lesson = Lesson.all.find(params[:lesson_id])
            if lesson.day<=Date.today
                render json: JSON[{"error": "you can't delete past or today lessons"}], status: :forbidden
            elsif lesson.user_id!=@user.id && lesson.tutor_id!=@user.id && @user.role_id!=Role.all.find_by_name("administrator").id
                render json: JSON[{"error": "you are not authorized to do this action"}], status: :unauthorized
            else
                lesson.destroy
                render json: JSON[{"status": "accepted"}], status: :accepted
            end
        rescue StandardError => e
            render json: JSON[{"error": "lesson doesn't exist"}], status: :not_found
        end
    end

    # Show show all user's lessons (only students)
    #
    # == HTTP_METHOD:
    # GET
    # == Route:
    # /lessons/get_student_lessons
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # == Response:
    # render::
    #   list of lessons
    # status::
    #   ok
    def get_student_lessons
        lessons = @user.lessons
        lessons_helper = lessons.map{|le| lesson_info(le)}
        render json: lessons_helper, status: :ok
    end

    # Show show all tutor's lessons
    #
    # == HTTP_METHOD:
    # GET
    # == Route:
    # /lessons/get_tutor_lessons
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # tutor_id::
    #   id of the tutor
    # == Response:
    # render::
    #   list of lessons
    # status::
    #   ok
    def get_tutor_lessons
        lessons = User.all.find(params[:tutor_id]).tutorLessons
        lessons_helper = lessons.map{|le| lesson_info(le)}
        render json: lessons_helper, status: :ok
    end
end