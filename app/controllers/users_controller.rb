class UsersController < ApplicationController
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
end
