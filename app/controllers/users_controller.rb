class UsersController < ApplicationController
  before_action :require_login, only: [:feed, :edit, :update] 
  before_action :do_not_require_login, only: [:create]
  
  def new
    @user = User.new
     render :layout => 'apps'
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @is_follow = Follow.find_by_user_id_and_followers_id(params[:id], current_user.id) if current_user
  end

  def feed
    @user = current_user
    @new_tweet = Tweet.new
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :avatar)
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
end
