class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def activate
    user = User.find_by_register_digest(params[:id])
    if user.present?
      user.activate = true
      user.save
    else
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
