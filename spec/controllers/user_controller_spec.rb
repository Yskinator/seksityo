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
  end
end