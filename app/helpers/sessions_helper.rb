module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    session[:username] = user.username
  end
end
