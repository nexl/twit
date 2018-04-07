class User < ApplicationRecord
  has_many :tweet, :dependent => :destroy
  
  validates :email, :presence => true, :uniqueness => true
  has_secure_password

  before_create :create_digest
  after_create :registration_mail

  has_attached_file :avatar
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

end
