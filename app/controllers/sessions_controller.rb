class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to root_path
    else
      flash[:error] = "There is something wrong with your username or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have succesfully logged out."
    redirect_to root_path
  end
end