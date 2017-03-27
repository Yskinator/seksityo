require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe "GET index" do
    it "renders the index page if correct credentials" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
       @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
      get :index
      expect(response).to render_template("index")
    end
    it "should not render index if incorrect credentials" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
       @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("wrong","credentials")
      get :index
      expect(response.status).to equal(401)
    end
    it "should not render index with no credentials at all" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
      get :index
      expect(response.status).to equal(401)
    end
  end
end
