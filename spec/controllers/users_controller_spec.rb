require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET homepage" do
    it "has a 200 status code" do
      get :homepage
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    let(:user) { FactoryBot.create :user }
    before { get :show, :params => { id: user.id }, session: { :user_id => user.id, :username => user.username } }
    
    it "has a 200 status code" do 
      expect(response.status).to eq(200)
    end

    it "assigns the requested user details to user" do
      expect(assigns(:user)).to eq user
    end
  
    it "renders the show template" do
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    let(:user_attributes) { FactoryBot.attributes_for(:another_user) }

    context "with valid attributes" do
      #it "create new user" do
      #  expect{ post :create, :params => { :user => user_attributes } }.to change(User, :count).by(1)
      #end
    end  
    
    context "with invalid attributes" do
      it "create new user without email" do
        expect{ post :create, :params => { :user => { :username => "sawa", :password => "sawa" } } }.to change(User, :count).by(0)
      end

      it "create new user without username" do
        expect{ post :create, :params => { :user => { :email => "sawako@mailinator.com", :password => "sawa" } } }.to change(User, :count).by(0)
      end

      it "username already exist" do
        post :create, :params => { :user => user_attributes }
        expect{ post :create, :params => { :user => { :username => "kanako", :email => "sawa@mailinator.com", :password => "sawa" } } }.to change(User, :count).by(0)
      end
    end
  end

  describe "GET edit" do
    let(:user) { FactoryBot.create(:user) }
    before { get :edit, :params => { :id => user.id },  session: { "user_id" => user.id, "username" => user.username } }
    
    it "has a 200 status code" do
      expect(response).to have_http_status(:ok)
    end
    
    it "assigns the requested user details to user" do
      expect(assigns(:user)).to eq user
    end
    
    it "renders the edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    let(:user) { FactoryBot.create(:update_user) }
    
    it "saves updated user" do
      # expect { patch :update, :params => { :id => user.to_param, :user => { :username => 'sawako', :email => 'sawako@mailinator.com' } } , session: { :user_id => user.id, username => user.username } }.to change(User, :count).by(0)
    end

    it "updated user data" do
      # patch :update, :params => { :id => user.to_param, :user => { :username => 'sawako', :email => 'sawako@mailinator.com' }, session: {  :user_id => user.id, :username => user.username } } 
      # user.reload
      # expect(user.username).to eq "sawako"
      # expect(user.email).to eq "sawako@mailinator.com"
    end
  end
end