class Tweet < ApplicationRecord
  belongs_to :user, :foreign_key => "user_id"

  validates :message, :presence => true, :length => {:maximum => 140}

  def self.user_tweet(user_id)
    where(:user_id => user_id)
  end

  def self.followed_tweet(user_id)
    following_ids = "select user_id from follows where followers_id = #{user_id}"
    where("user_id IN (#{following_ids})")
  end
end
