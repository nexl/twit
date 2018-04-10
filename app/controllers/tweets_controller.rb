class TweetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login 
  
  def create
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      format.json do 
        if @tweet.save
          render :json => @tweet, :include => { :user => { :only => [:id, :username], :methods => [:avatar_url, :user_url] } }
        else
          render :json => { :errors => @tweet.errors.messages }, :status => 422
        end
      end
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:user_id, :message).merge(:user_id => current_user.id)
  end
end
