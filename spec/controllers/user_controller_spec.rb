require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET users" do
    it "renders the phone input page" do
      get :phone_form
      expect(response).to render_template("phone_form")
    end
  end
  describe "POST users" do
    user_params = {:phone_number => "0401231234"}
    it "creates a new user if it does not exist" do
      expect { post :create_or_find, :user => user_params }.to change(User, :count).by(1)
    end
    it "generates a code for the user" do
      post :create_or_find, :user => user_params
      @user = User.find_by_phone_number("0401231234")
      expect(@user.code).not_to equal(nil)
    end
    it "adds the code to cookies" do
      post :create_or_find, :user => user_params
      @user = User.first
      expect(@response.cookies['code']).to eq(@user.code)
    end
    it "does not create a new user if a user corresponding to the number already exists" do
      post :create_or_find, :user=>user_params
      expect { post :create_or_find, :user => user_params }.to change(User, :count).by(0)
    end
  end
end