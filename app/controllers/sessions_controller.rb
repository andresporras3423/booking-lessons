class SessionsController < ApplicationController
    # Login to generate a token
    #
    # == HTTP_METHOD:
    #   POST
    # == Route:
    # /sessions/create
    # == Headers:
    # email::
    #   email of the user
    # password::
    #   user's password
    # == Response:
    # render::
    #   User's id, email, name, remember_token
    # status::
    #   ok
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
    #destroy token of the logged user
    #
    # == HTTP_METHOD:
    #   DELETE
    # == Route:
    # /sessions/destroy
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # == Response:
    # render::
    #   User's id, email, name
    # status::
    #   accepted
    def destroy
        user = User.find_by_email(params[:email])
        if user&.authenticated?(params[:remember_token])
            user.remember_token=nil
            user.save
            render json: user.as_json(only: [:id, :email, :name]), status: :accepted
        else
            head(:not_found)
        end
    end
end