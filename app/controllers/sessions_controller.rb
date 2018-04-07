class SessionsController < ApplicationController
  def new
    @session = User.new
    render :layout => 'apps'
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      helpers.login(user)
      redirect_to user_path(user)
    else
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to new_user_path
  end
end
