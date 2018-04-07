class TweetsController < ApplicationController
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to feed_path
    else
      redirect_to root_path
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:user_id, :message).merge(:user_id => current_user.id)
  end
end
