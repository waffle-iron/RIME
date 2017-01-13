class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Password Reset Email Sent"
      redirect_to root_url

    else
      flash.now[:danger] = "No User Found Wit That Email"
      render 'new'
    end
  end

  def edit
  end
end
