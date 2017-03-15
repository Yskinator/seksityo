require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  describe "GET show" do
    it "renders the show template" do
      Meeting.create(nickname: "Matti", phone_number: "0401231234", duration: 20)
      get :show, id: 1
      expect(response).to render_template("show")
    end
  end
  describe "GET alert_confirm" do
    it "renders the alert confirmation template" do
      @meeting = Meeting.create(nickname: "Matti", phone_number: "9991231234", duration: 42)
      @meeting.create_hashkey
      @request.cookies['current_meeting'] = @meeting.hashkey
      @meeting.save
      get :alert_confirm
      expect(response).to render_template("alert_confirm")
    end
    it "redirects to root if cookie is incorrect" do
      Meeting.create(nickname: "Matti", phone_number: "9991231234", duration: 42)
      @request.cookies['current_meeting'] = "Even incorrect cookies are tasty."
      get :alert_confirm
      expect(response).to redirect_to("/")
    end
  end
  describe "DELETE delete" do
    it "deletes the specified meeting" do
      @meeting = Meeting.create(nickname: "Matti", phone_number: "0401231234", duration: 20)
      get :destroy, id: @meeting.id
      expect(Meeting.count).to eq(0)
    end
  end
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
    it "renders status page if hash found in cookies and database" do
      @meeting = Meeting.create(nickname: "Matti", phone_number: "0401231234", duration: 20)
      @meeting.create_hashkey
      @request.cookies['current_meeting'] = @meeting.hashkey
      @meeting.save
      get :new
      expect(response).to redirect_to('/meeting')
    end
  end
  describe "GET edit" do
    it "renders the edit template" do
      @meeting = Meeting.create(nickname: "Matti", phone_number: "0401231234", duration: 20)
      get :edit, id: @meeting.id
      expect(response).to render_template("edit")
    end
  end
  describe "POST create" do
    it "should create new meeting with correct params" do
        meeting_params = {:nickname => "Pekka", :phone_number => "0401231234", :duration => 30}
        expect { post :create, :meeting => meeting_params }.to change(Meeting, :count).by(1)
    end
    it "should not create new meeting with negative duration" do
      meeting_params = {:nickname => "Pekka", :phone_number => "0401231234", :duration => -1}
      expect { post :create, :meeting => meeting_params }.to change(Meeting, :count).by(0)
    end
    it "should not create new meeting with duration over 24h" do
      meeting_params = {:nickname => "Pekka", :phone_number => "0401231234", :duration => 1440}
      expect { post :create, :meeting => meeting_params }.to change(Meeting, :count).by(0)
    end
    it "should not create new meeting with string input duration" do
      meeting_params = {:nickname => "Pekka", :phone_number => "0401231234", :duration => "sdfd"}
      expect { post :create, :meeting => meeting_params }.to change(Meeting, :count).by(0)
    end
    it "should not create new meeting with invalid phone number" do
      meeting_params = {:nickname => "Pekka", :phone_number => "123", :duration => 30}
      expect { post :create, :meeting => meeting_params }.to change(Meeting, :count).by(0)
    end
    it "should create a delayed job" do
      meeting_params = {:nickname => "DelayedForEver", :phone_number => "0401231234", :duration => "1"}
      expect {post :create, :meeting => meeting_params}.to change {Delayed::Job.count}.by(1)
    end
    it "should run the delayed job" do
      meeting_params = {:nickname => "BackgroundProcessed", :phone_number => "0401231234", :duration => "1"}
      Delayed::Worker.delay_jobs = false
      expect {post :create, :meeting => meeting_params}.to change {Delayed::Job.count}.by(0)
      Delayed::Worker.delay_jobs = true
    end
  end
  describe "PUT update" do
    it "should update Meeting" do
      attr = { :nickname => "Pekka"}
      @meeting = Meeting.create(nickname: "Matti", phone_number: "0401231234", duration: 20)
      put :update, id: @meeting.id, :meeting => attr
      @meeting.reload
      expect(@meeting.nickname).to eq("Pekka")
      expect(response).to redirect_to('/meeting')
    end
  end
  describe "POST send_alert" do
    it "should remove incorret cookie" do
      @meeting = Meeting.create(nickname: "Cookie breaker", phone_number: "0401231234", duration: 99999)
      @request.cookies["current_meeting"] = "dog treat"
      post :send_alert
      expect(@response.cookies["current_meeting"]).to equal(nil)
    end
    it "should redirect to meet creation when the user has an incorret cookie" do
      @meeting = Meeting.create(nickname: "Cookie breaker", phone_number: "0401231234", duration: 99999)
      @request.cookies["current_meeting"] = "dog treat"
      post :send_alert
      expect(response).to redirect_to(:root)
    end
  end
  describe "POST meeting_ok" do
    it "should remove cookie" do
      @meeting = Meeting.create(nickname: "Cookie breaker", phone_number: "0401231234", duration: 20)
      @meeting.create_hashkey
      @request.cookies['current_meeting'] = @meeting.hashkey
      @meeting.save
      post :meeting_ok
      expect(@response.cookies['current_meeting']).to equal(nil)
    end
    it "should delete the meeting from database" do
      @meeting = Meeting.create(nickname: "Testuser", phone_number: "0401231234", duration: 10)
      @meeting.create_hashkey
      @request.cookies['current_meeting'] = @meeting.hashkey
      @meeting.save
      post :meeting_ok
      expect(Meeting.count).to eq(0)
    end
    it "should delete the associated delayed_job" do
      #To properly create a job the meeting has to be created via a post to create. Best not ask why.
      meeting_params = {:nickname => "Pekka", :phone_number => "0401231234", :duration => 30}
      post :create, :meeting => meeting_params
      @meeting = Meeting.find_by_nickname("Pekka")
      expect(Delayed::Job.all.length).to eq(1)
      post :meeting_ok
      expect(Delayed::Job.all.length).to eq(0)
    end
    it "should redirect to root" do
      @meeting = Meeting.create(nickname: "Test", phone_number: "testi@testi.test", duration: 10)

      @meeting.create_hashkey
      @request.cookies['current_meeting'] = @meeting.hashkey
      @meeting.save
      post :meeting_ok
      expect(response).to redirect_to(:root)
    end
  end
end
