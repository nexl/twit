class Tweet < ApplicationRecord
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :main_tweet, :class_name => 'Tweet', :foreign_key => "parent_id", :optional => true
  has_many :comment_tweet, :class_name => 'Tweet', :foreign_key => "parent_id"

  default_scope{order(created_at: :desc)}

  validates :message, :presence => true, :length => {:maximum => 140}
  validates :user_id, :presence => true
  
  def created_at_format
    created_at.strftime('%d-%m-%Y %H:%M:%S')
  end
end
