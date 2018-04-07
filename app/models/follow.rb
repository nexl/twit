class Follow < ApplicationRecord
  belongs_to :followers, class_name: "User", :foreign_key => "followers_id"
  belongs_to :following, class_name: "User", :foreign_key => "user_id"

  validates_uniqueness_of :user_id, scope: :followers_id
end
