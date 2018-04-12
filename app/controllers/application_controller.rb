class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user
  end

  def require_login
    return redirect_to login_path unless logged_in? && current_user.activate
  end
  
  def do_not_require_login
    redirect_to root_path if logged_in?
  end
end
