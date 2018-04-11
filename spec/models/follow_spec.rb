require "rails_helper"
RSpec.describe Follow, :type => :model do
  it "follow someone" do
    follow = FactoryBot.create(:follow)
    expect(follow).to be_valid
  end

  it "unfollow someone" do
  end
end