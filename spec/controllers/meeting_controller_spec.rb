require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  describe "GET show" do
    it "renders the show template" do
      Meeting.create(nickname: "Matti", phone_number: 0401231234, duration: 20)
      get :show, id: 1
      expect(response).to render_template("show")
    end
  end
  describe "DELETE delete" do
    it "deletes the specified meeting" do
      Meeting.create(nickname: "Matti", phone_number: 0401231234, duration: 20)
      get :destroy, id: 1
      expect(Meeting.count).to eq(0)
    end
  end
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  describe "GET edit" do
    it "renders the edit template" do
      Meeting.create(nickname: "Matti", phone_number: 0401231234, duration: 20)
      get :edit, id: 1
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
  end
  describe "PUT update" do
    it "should update Meeting" do
      attr = { :nickname => "Pekka"}
      @meeting = Meeting.create(nickname: "Matti", phone_number: 0401231234, duration: 20)
      put :update, id: 1, :meeting => attr
      @meeting.reload
      expect(@meeting.nickname).to eq("Pekka")
      expect(response).to redirect_to(@meeting)
    end
  end
end
