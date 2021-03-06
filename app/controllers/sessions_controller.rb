class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
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

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by_pin(params[:pin])
      if user
        user.remove_pin!
        session[:two_factor] = nil
        login_user!(user)
      else
        flash[:error] = 'Sorry, something is wrong with your pin number.'
        redirect_to pin_path
      end
    end
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "Welcome, you've logged in."
    redirect_to root_path
  end
end