class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = 'You must be logged in to do that.'
      redirect_back fallback_location: root_path
    end
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end

  def access_denied
    flash[:error] = 'You cannot do that.'
    redirect_to root_path
  end
end
