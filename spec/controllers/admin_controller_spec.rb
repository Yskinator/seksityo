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
    context "sort methods" do
      render_views
      it "should arrange correctly with default sort" do
        User.create(username: "admin", password: "admin", password_confirmation: "admin")
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
        s1 = Stat.new
        s1.country_code = "22222"
        s1.save
        s2 = Stat.new
        s2.country_code = "11111"
        s2.save
        m = Meeting.new(nickname: "Vanha", created_at: Time.new(2015), duration: 1337)
        m.save(:validate => false)
        m = Meeting.new(nickname: "Uusi", created_at: Time.new(2017), duration: 1337)
        m.save(:validate => false)

        get :index
        expect(response.body.index("22222")).to be > response.body.index("11111")
        expect(response.body.index("Vanha")).to be > response.body.index("Uusi")
      end
      it "should arrange correctly with given sort params" do
        User.create(username: "admin", password: "admin", password_confirmation: "admin")
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
        s1 = Stat.new
        s1.country_code = "22222"
        s1.created = 42
        s1.save
        s2 = Stat.new
        s2.country_code = "11111"
        s2.created = 2
        s2.save
        m = Meeting.new(nickname: "Vanha", created_at: Time.new(2015), duration: 1337)
        m.save(:validate => false)
        m = Meeting.new(nickname: "Uusi", created_at: Time.new(2017), duration: 1337)
        m.save(:validate => false)

        get :index, stat_sort: "created", stat_direction: "desc", meeting_sort: "created_at", meeting_direction: "asc"
        expect(response.body.index("11111")).to be > response.body.index("22222")
        expect(response.body.index("Uusi")).to be > response.body.index("Vanha")
      end
    end
  end
  describe "DELETE :id" do
    render_views
    before :each do
      @request.env['HTTP_REFERER'] = "/admin"
    end
    it "should delete existing meeting if authenticated" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
      @meeting = Meeting.new
      @meeting.save(:validate => false)
      delete :destroy, id: @meeting.id
      expect(Meeting.count).to eq(0)
      expect(response.status).to eq(302)
    end
    it "should not delete existing meeting if not authenticated" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
      @meeting = Meeting.new
      @meeting.save(:validate => false)
      delete :destroy, id: @meeting.id
      expect(Meeting.count).to eq(1)
      expect(response.status).to eq(401)
    end
    it "should not delete existing meeting if invalid credentials" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("wrong","credentials  ")
      @meeting = Meeting.new
      @meeting.save(:validate => false)
      delete :destroy, id: @meeting.id
      expect(Meeting.count).to eq(1)
      expect(response.status).to eq(401)
    end
    it "should not delete meeting that does not exist" do
      u = User.create(username: "admin", password: "admin", password_confirmation: "admin")
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
      @meeting = Meeting.new
      @meeting.save(:validate => false)
      delete :destroy, id: 12312
      expect(Meeting.count).to eq(1)
      expect(response.status).to eq(302)
    end

  end
end
