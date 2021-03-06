class UsersController < ApplicationController
    #Routed for the /signup page
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            @user.send_activation_email
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url

        else
            render 'new' #Reset the signup page
        end
    end

    def signup_success

    end

    private
        #Defines which fields are permitted/required when making a new user.
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
