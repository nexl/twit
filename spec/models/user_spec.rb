require "rails_helper"
RSpec.describe User, :type => :model do
  it "create new user" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "user has no email" do 
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "user has no username" do 
    user = FactoryBot.build(:user, username: nil)
    expect(user).to_not be_valid
  end

  it "user has no password" do 
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "duplicate email" do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.build(:another_user, email: "misora@mailinator.com")
    expect(user2).to_not be_valid
  end

  it "duplicate username" do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.build(:another_user, username: "misora")
    expect(user2).to_not be_valid
  end
end