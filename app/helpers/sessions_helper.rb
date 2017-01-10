module SessionsHelper

    #Allows us to log people in using the same technique from multiple places.
    def log_in(user)
        session[:user_id] = user.id
    end

    #What is the currently logged-in user?
    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    #Is the user logged in right now?
    def logged_in?
        !current_user.nil?
    end
end
