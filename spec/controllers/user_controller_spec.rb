require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET phone_input" do
    it "renders the phone input page" do
      get :phone_form
      expect(response).to render_template("phone_form")
    end
    it "generates a code for the user" do
      @user = User.first
      expect(@user).to equal(nil)
      get :create_or_find
      @user = User.first
      expect(@user.code).not_to equal(nil)
    end
    it "adds the code to cookies" do
      get :create_or_find
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
    it "does not generate a new code if the user already has one" do
      @user = User.new
      @user.create_code
      @request.cookies['code'] = @user.code
      @user.save
      get :create_or_find
      expect(@request.cookies['code']).to eq(@user.code)
    end
    it "adds new user to database" do
      expect(User.all.length).to eq(0)
      get :create_or_find
      expect(User.all.length).to eq(1)
    end
    it "generates a new code if the user found in cookies not found in database" do
      @request.cookies['code'] = 'wrongcookie'
      get :create_or_find
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
  end
end