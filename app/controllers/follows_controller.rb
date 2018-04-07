class FollowsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    follow = Follow.new(:user_id => user.id, :followers_id => current_user.id)
    if follow.save
      redirect_to user_path(follow.user_id)
    else
      redirect_to root_path
    end
  end

  def destroy
    follow = Follow.find_by_user_id_and_followers_id(params[:user_id], current_user.id)
    if follow.present?
      follow.destroy
      redirect_to user_path(params[:user_id])
    else
      redirect_to root_path
    end
  end
end
