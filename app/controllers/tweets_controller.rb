class TweetsController < ApplicationController
  before_action :require_login 
  skip_before_action :verify_authenticity_token
  
  def create
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      format.json do 
        if @tweet.save
          render :json => @tweet, :methods => :created_at_format, :include => [{ 
            :user => { :only => [:id, :username], :methods => [:avatar_url, :user_url]} }, 
            :comment_tweet]
        else
          render :json => { :errors => @tweet.errors.messages }, :status => 422
        end
      end
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:user_id, :message, :parent_id).merge(:user_id => current_user.id)
  end
end
