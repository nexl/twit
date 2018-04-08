require "rails_helper"
RSpec.describe Tweet, :type => :model do
  it "create a new tweet" do
    tweet = FactoryBot.build(:tweet)
    expect(tweet).to be_valid
  end

  it "tweet without message" do
    tweet = FactoryBot.build(:tweet, message: nil)
    expect(tweet).to_not be_valid
  end

  it "tweet with more than 140 characters" do
    tweet = FactoryBot.build(:another_tweet)
    expect(tweet).to_not be_valid
  end
end