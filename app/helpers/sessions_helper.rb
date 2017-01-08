module SessionsHelper

    #Allows us to log people in using the same technique from multiple places.
    def log_in(user)
        session[:user_id] = user.id
    end
end
