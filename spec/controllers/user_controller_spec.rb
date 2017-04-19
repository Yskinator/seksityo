require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET users" do
    it "renders the phone input page" do
      get :phone_form
      expect(response).to render_template("phone_form")
    end
  end
  describe "GET credits" do
    it "renders the out of credits page if user has no credits" do
      u = User.create({phone_number: "9991231234"})
      u.create_code
      @request.cookies['ucd'] = u.code
      u.credits = 0
      u.save

      get :out_of_credits
      expect(response).to render_template("out_of_credits")
    end
    it "renders root if user with cookiecode has credits" do
      u = User.create({phone_number: "9991231234"})
      u.create_code
      @request.cookies['ucd'] = u.code
      u.credits = 10;
      u.save

      get :out_of_credits
      expect(response).to redirect_to(:root)
      
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
      expect(@response.cookies['ucd']).to eq(@user.code)
    end
    it "does not create a new user if a user corresponding to the number already exists" do
      post :receive_phone, :user=>user_params
      expect { post :receive_phone, :user => user_params }.to change(User, :count).by(0)
    end
  end
  describe "GET recover_cookie" do
    it "changes your cookie if user with code is found on database" do
      @request.cookies['ucd'] = "lörslärä"
      u = User.create(phone_number: "9991231234")

      get :recover_cookie, :id => u.code

      expect(@response.cookies['ucd']).to eq(u.code)
    end

    it "doesn't change your cookie if no user is found with given id" do
      @request.cookies['ucd'] = 'originalcode'
      get :recover_cookie, :id => 'bad_id'

      expect(@response.cookies['ucd']).to eq(nil)
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
  describe "GET receive_phone" do
    it "should show SMS sent view if user's phone number found in database" do
      u = User.create(phone_number: "9991231234")
      attr = { :phone_number => "9991231234"}
      get :receive_phone, :user => attr

      expect(response).to render_template("sms_sent")
    end
    it "should redirect to root if phone number not found in database" do
      attr = { :phone_number => "9991231234"}
      get :receive_phone, :user => attr

      expect(response).to redirect_to(:root)
    end
    it "should create a new user if phone number not found in database" do
      attr = { :phone_number => "9991231234"}
      get :receive_phone, :user => attr

      user = User.find_by_phone_number("9991231234")
      expect(user).not_to eq(nil)
    end
  end
end
