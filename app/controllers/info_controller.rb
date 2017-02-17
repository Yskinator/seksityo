class InfoController < ApplicationController


    # GET /about
    def show
        render :layout => false
    end

    # Creates temporary meeting to demo the status page on the info page. Meeting is NOT saved to the db.
    def statusdemo
        @meeting = Meeting.new(phone_number: "asd@asd.fi", nickname: "pekka", duration: 30, created_at: Time.now, id: 666)
        render '/meetings/show.html.erb'
    end

end
