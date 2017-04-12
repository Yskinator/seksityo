require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET users" do
    it "renders the phone input page" do
      get :phone_form
      expect(response).to render_template("phone_form")
    end
  end
  describe "GET credits" do
    it "renders the out of credits apge" do
      get :out_of_credits
      expect(response).to render_template("out_of_credits")
    end
  end
  describe "POST users" do
    user_params = {:phone_number => "0401231234"}
    it "creates a new user if it does not exist" do
      expect { post :receive_phone, :user => user_params }.to change(User, :count).by(1)
    end
    it "generates a code for the user" do
      post :receive_phone, :user => user_params
      @user = User.find_by_phone_number("0401231234")
      expect(@user.code).not_to equal(nil)
    end
    it "adds the code to cookies" do
      post :receive_phone, :user => user_params
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
    it "does not create a new user if a user corresponding to the number already exists" do
      post :receive_phone, :user=>user_params
      expect { post :receive_phone, :user => user_params }.to change(User, :count).by(0)
    end
  end
  describe "POST update" do
    it "should update user" do
      u = Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
      attr = { :credits => "12"}
      @user = User.create(code: "1234", phone_number: "0401231234", credits: 0)
      put :update, id: @user.id, :user => attr
      @user.reload
      expect(@user.credits).to eq(12)
      expect(response).to redirect_to('/admin')
    end
    it "should not update user if not authenticated" do
      u = Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
      attr = { :credits => "12"}
      @user = User.create(code: "1234", phone_number: "0401231234", credits: 0)
      put :update, id: @user.id, :user => attr
      @user.reload
      expect(@user.credits).to eq(0)
      expect(response.status).to eq(401)
    end
  end
end