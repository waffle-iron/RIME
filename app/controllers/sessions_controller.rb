
#Handles login sessions.
class SessionsController < ApplicationController
  def new

  end

  def create
      user = User.find_by(email: params[:session][:email].downcase) #email is stored in lowercase in the db

      if user && user.authenticate(params[:session][:password])
          if user.activated?
              log_in user
              remember user
              redirect_to chat_rooms_path
          else
              message = "Account Not Activated "
              message += "Please check your email for the activation link."
              flash[:warning] = message
              redirect_to root_url
          end
      else
          flash.now[:danger] = "Invalid email and/or password." #adds a flash message to be displayed on the next page
          render 'new'  #shows the login page.
      end
  end

  def destroy
      log_out if logged_in?
      redirect_to root_url
  end
end
