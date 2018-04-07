class User < ApplicationRecord
  has_many :tweet, :dependent => :destroy
  has_many :followers, class_name: "Follow", :foreign_key => "user_id"
  has_many :following, class_name: "Follow", :foreign_key => "followers_id"

  validates :email, :presence => true, :uniqueness => true
  has_secure_password

  before_create :create_digest
  after_create :registration_mail

  has_attached_file :avatar, default_url: "default_avatar.png"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg"]

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_digest
    self.register_digest = User.new_token
  end

  def registration_mail
    UserMailer.activation_mail(self).deliver_now
  end
  
  def total_tweet
    tweet.where(:user_id => id).count
  end

  def total_followers
    followers.count
  end

  def total_following
    following.count
  end
end
