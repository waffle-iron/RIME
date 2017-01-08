
#Handles login sessions.
class SessionsController < ApplicationController
  def new

  end

  def create
      user = User.find_by(email: params[:session][:email].downcase) #email is stored in lowercase in the db

      if user && user.authenticate(params[:session][:password])

      else
          flash[:danger] = "Invalid email and/or password." #adds a flash message to be displayed on the next page
          render 'new'  #shows the login page.
      end
  end

  def destroy

  end
end
