class User < ApplicationRecord
  validates :email, :presence => true, :uniqueness => true
  has_secure_password

  before_create :create_digest
  after_create :registration_mail
  
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
