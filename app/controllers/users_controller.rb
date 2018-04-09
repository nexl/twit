class UsersController < ApplicationController
  before_action :require_login, only: [:feed] 
  before_action :do_not_require_login, only: [:create]
  
  def new
    new_variables
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    find_variables
  end

  def update
    find_variables
    @user.update_attributes(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def show
    find_variables
    @is_follow = Follow.find_by_user_id_and_followers_id(params[:id], current_user.id) if current_user
  end

  def feed
    feed_variables
  end

  def homepage
    if logged_in?
      feed_variables
      render :action => 'feed'
    else
      new_variables
      render :action => 'new'
    end   
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :avatar)
  end

  def feed_variables
    @user = current_user
    @new_tweet = Tweet.new
  end

  def new_variables
    @user = User.new
  end

  def find_variables
    @user = User.find(params[:id])
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
