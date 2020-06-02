class UsersController < ApplicationController
    before_action :restrict_access, only: %i[update_subjects]
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
        @user.user_subjects.each{|us| us.destroy}
        user_subjects = sub_ids.split(",").map do |s_id|
            UserSubject.create(user_id: @user.id, subject_id: s_id.to_i)
        end
        # UserSubject.create(user_subjects)
    end
end
