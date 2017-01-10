
#Handles login sessions.
class SessionsController < ApplicationController
  def new

  end

  def create
      user = User.find_by(email: params[:session][:email].downcase) #email is stored in lowercase in the db

      if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to root_url   #Once chat stuff is up and running, this will redirect to the chat home.
      else
          flash.now[:danger] = "Invalid email and/or password." #adds a flash message to be displayed on the next page
          render 'new'  #shows the login page.
      end
  end

  def destroy
      log_out
      redirect_to root_url
  end
end
