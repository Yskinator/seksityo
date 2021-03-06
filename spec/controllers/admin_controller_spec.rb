require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe "GET index" do
    it "renders the index page if correct credentials" do
      u = Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
       @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
      get :index
      expect(response).to render_template("index")
    end
    it "should not render index if incorrect credentials" do
      u = Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
       @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("wrong","credentials")
      get :index
      expect(response.status).to equal(401)
    end
    it "should not render index with no credentials at all" do
      u = Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
      get :index
      expect(response.status).to equal(401)
    end
    context "sort methods" do
      render_views
      it "should arrange correctly with default sort" do
        Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
        s1 = Stat.new
        s1.country = "Zimbabwe"
        s1.save
        s2 = Stat.new
        s2.country = "Aasia"
        s2.save
        m = Meeting.new(nickname: "Vanha", created_at: Time.new(2015), duration: 1337, alert_sent: false)
        m.save(:validate => false)
        m = Meeting.new(nickname: "Uusi", created_at: Time.new(2017), duration: 1337, alert_sent: true)
        m.save(:validate => false)
        u = User.new(phone_number: "9991231234")
        u.credits=99999
        u.save(:validate => false)
        credit_99999 = u.code
        u = User.new(phone_number: "9991231234")
        credit_0 = u.code
        u.save(:validate => false)

        get :index
        expect(response.body.index("Zimbabwe")).to be > response.body.index("Aasia")
        expect(response.body.index("false")).to be > response.body.index("true")
        expect(response.body.index(credit_99999)).to be > response.body.index(u.code)
      end
      it "should arrange correctly with given sort params" do
        Admin.create(username: "admin", password: "admin", password_confirmation: "admin")
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","admin")
        s1 = Stat.new
        s1.country_code = "22222"
        s1.created = 42
        s1.save
        s2 = Stat.new
        s2.country_code = "11111"
        s2.created = 2
        s2.save
        m = Meeting.new(nickname: "Vanha", created_at: Time.new(2015), duration: 1337, alert_sent: false)
        m.save(:validate => false)
        m = Meeting.new(nickname: "Uusi", created_at: Time.new(2017), duration: 1000, alert_sent: true)
        m.save(:validate => false)
        u = User.new(phone_number: "9991231234")
        u.credits = 99999
        credit_99999 = u.code
        u.save(:validate => false)
        u = User.new(phone_number: "9991231234")
        credit_0 = u.code
        u.save(:validate => false)

        get :index, stat_sort: "created", stat_direction: "desc", meeting_sort: "time_to_live", meeting_direction: "desc", user_sort: "credits", user_direction: "desc"
        expect(response.body.index("11111")).to be > response.body.index("22222")
        expect(response.body.index("false")).to be > response.body.index("true")
        expect(response.body.index(credit_0)).to be > response.body.index(credit_99999)
      end
    end
  end
end
