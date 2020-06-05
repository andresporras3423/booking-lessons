module SessionsHelper
    # Remembers a user in a persistent session.
    # def remember(user)
    #   cookies.permanent.signed[:user_id] = user.id
    #   cookies.permanent[:remember_token] = user.remember_token
    # end
  
    # Returns the current logged-in user (if any).
    # def current_user
    #   return unless (user_id = cookies.signed[:user_id])
  
    #   user = User.find_by(id: user_id)
    #   return unless user&.authenticated?(cookies[:remember_token])
  
    #   current_user_equal(user)
    # end
  
    # def current_user_equal(user)
    #   @current_user = user
    # end
  
    # Returns true if the user is logged in, false otherwise.
    # def logged_in?
    #   !current_user.nil?
    # end
  
    # Logs out the current user.
    # def log_out
    #   cookies.signed[:user_id] = nil
    #   cookies[:remember_token] = nil
    #   @current_user = nil
    # end
    @user=nil
  
    def restrict_access
        @user = User.find_by_email(params[:email])
        unless @user&.authenticated?(params[:remember_token])
            @user=nil
            render json: {"error": "you must be logged to do this action"} , status: :unauthorized
        end
    end

    def only_students
        msg = {"error": "action only allowed to students"}
        allow_by_role(Role.all.find_by_name("student").id, msg)
    end

    def only_tutors
        msg = {"error": "action only allowed to tutors"}
        allow_by_role(Role.all.find_by_name("tutor").id, msg)
    end

    def only_administrators
        msg = {"error": "action only allowed to administrators"}
        allow_by_role(Role.all.find_by_name("administrator").id, msg)
    end

    def allow_by_role(role_id, msg)
        if role_id!=@user.role_id
            render json: msg , status: :unauthorized
        end
    end
  end