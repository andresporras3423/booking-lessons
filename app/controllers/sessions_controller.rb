class SessionsController < ApplicationController

    def create
        user = User.find_by_email(params[:email])
        p "send password is #{params[:password]}"
        if user.authenticate(params[:password])
            user.record_signup
            user.save
            render json: user.as_json(only: [:id, :email, :name, :remember_token]), status: :created
        else
            head(:unauthorized)
        end
    end

    def destroy
        user = User.find_by_email(params[:email])
        if user&.authenticated?(params[:remember_token])
            user.remember_token=nil
            user.save
            render json: user.as_json(only: [:id, :email, :name]), status: :ok
        else
            head(:not_found)
        end
    end

    # def create
    #     user = User.find_by_name(params[:name])
    #     if user&.authenticate(params[:password])
    #       remember user
    #       redirect_to '/'
    #     else
    #       flash.now[:danger] = 'Invalid email/password combination'
    #       render 'new'
    #     end
    #   end
    
    #   def destroy
    #     log_out if logged_in?
    #     redirect_to '/login'
    #   end

end