class UsersController < ApplicationController
    before_action :restrict_access, only: %i[update_subjects show_tutors show_tutors_by_lesson show_past_lessons show_today_lessons show_future_lessons]
    def create
        user = User.create(name: params[:name], email: params[:email], password: params[:password], 
            password_confirmation: params[:password_confirmation], city_id: params[:city_id], role_id: params[:role_id])
        p "name: #{user.name}, email: #{user.email}, city_id: #{user.city_id}, role_id: #{user.role_id}"
        if user.valid?
            user.record_signup
            user.save
            render json: user.as_json(only: [:id, :email, :name, :remember_token]), status: :created
        else
            head(:unauthorized)
        end
    end

    def update_subjects
        sub_ids = params[:sub_ids]
        @user.userSubjects.each{|us| us.destroy}
        user_subjects = sub_ids.split(",").map do |s_id|
            UserSubject.create(user_id: @user.id, subject_id: s_id.to_i)
        end
        render json: JSON[{"status": "created"}], status: :created
        # UserSubject.create(user_subjects)
    end

    def show_tutors
        tutors = User.all.select{|t | t.role.name=='tutor' && t.city_id==@user.city_id}
        render json: tutors.as_json(only: [:id, :email, :name]), status: :ok
    end

    def show_tutors_by_lesson
        p "subject_id params: #{params[:subject_id]}"
        tutors = User.all.select{|t | t.role.name=='tutor' && t.city_id==@user.city_id && t.userSubjects.any?{|us| params[:subject_id]==us.subject_id}}
        render json: tutors.as_json(only: [:id, :email, :name]), status: :ok
    end

    def show_past_lessons
        lessons = @user.lessons
        lessons_helper = lessons.select{|le| le.day<Date.today}
        render json: lessons_helper, status: :ok
    end

    def show_today_lessons
        lessons = @user.lessons
        lessons_helper = lessons.select{|le| le.day==Date.today}
        render json: lessons_helper, status: :ok
    end

    def show_future_lessons
        lessons = @user.lessons
        lessons_helper = lessons.select{|le| le.day>Date.today}
        render json: lessons_helper, status: :ok
    end
end
