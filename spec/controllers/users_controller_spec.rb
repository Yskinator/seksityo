require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET code_generation" do
    it "renders the code generation page" do
      get :code_generation
      expect(response).to render_template("code_generation")
    end
  end
end