class SessionsController < ApplicationController
  before_action :do_not_require_login, only: [:create, :new]
  before_action :require_login, only: [:destroy] 
  
  def new; end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password]) && user.activate
      helpers.login(user)
      redirect_to feed_path
    else
      flash[:danger] =  "Please check your email / password and try again"
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end