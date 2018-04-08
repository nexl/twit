class Follow < ApplicationRecord
  belongs_to :followers, class_name: "User", :foreign_key => "user_id"
  belongs_to :following, class_name: "User", :foreign_key => "followers_id"

  validates_uniqueness_of :user_id, scope: :followers_id
  validates :user_id, :followers_id, :presence => true
end
