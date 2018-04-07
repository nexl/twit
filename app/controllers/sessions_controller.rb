class SessionsController < ApplicationController
  def new
    render :layout => 'apps'
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password]) && user.activate
      helpers.login(user)
      redirect_to feed_path
    else
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
