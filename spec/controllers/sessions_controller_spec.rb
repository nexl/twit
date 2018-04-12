require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "authentication" do
    render_views
    let(:user) { FactoryBot.create(:activated_user) }
    
    before :each do
      @request.host = "www.example.com"
    end
    
    it "login" do
      visit "/"
      fill_in "session_email", with: user.email
      fill_in "session_password", with: user.password
      click_button "Login"
      expect(page).to have_content "Followers"
    end
  end
end