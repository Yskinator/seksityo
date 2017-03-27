require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe "GET index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
