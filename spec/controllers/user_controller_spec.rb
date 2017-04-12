require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET code_generation" do
    it "renders the code generation page" do
      get :code_generation
      expect(response).to render_template("code_generation")
    end
    it "generates a code for the user" do
      @user = User.first
      expect(@user).to equal(nil)
      get :code_generation
      @user = User.first
      expect(@user.code).not_to equal(nil)
    end
    it "adds the code to cookies" do
      get :code_generation
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
    it "does not generate a new code if the user already has one" do
      @user = User.new
      @user.create_code
      @request.cookies['code'] = @user.code
      @user.save
      get :code_generation
      expect(@request.cookies['code']).to eq(@user.code)
    end
    it "adds new user to database" do
      expect(User.all.length).to eq(0)
      get :code_generation
      expect(User.all.length).to eq(1)
    end
    it "generates a new code if the user found in cookies not found in database" do
      @request.cookies['code'] = 'wrongcookie'
      get :code_generation
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
  end
  describe "GET cookie_recovery_link" do
    it "returns an empty link if phonenumber doesn't match any user" do
      get :cookie_recovery_link, :phone_number => "0401231234"

      expect(assigns(:recovery_link)).to eq('')
    end
    it "returns the correct link if phonenumber matches user" do
      u = User.new
      u.create_code
      u.phone_number = "0401231234"
      u.save
      get :cookie_recovery_link, :phone_number =>"0401231234"

      expect(assigns(:recovery_link)).to eq(request.base_url  + "/users/id=" + u.code)
    end
  end
  describe "GET recover_cookie" do
    it "changes your cookie if user with code is found on database" do
      u = User.new
      u.create_code
      u.save
      @request.cookies['code'] = 'wrongcookie'
      get :recover_cookie, :id => u.code

      expect(cookies['code']).to eq(u.code)
    end
    it "doesn't change your cookie if no user is found with given id" do
      request.cookies['code'] = 'originalcode'
      get :recover_cookie, :id => 'bad_id'
      
      expect(cookies['code']).to eq('originalcode')

    end
  end
end
