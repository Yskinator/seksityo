class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
   @meeting = Meeting.find_by_hashkey(cookies['current_meeting'])
  end

  # GET /meetings/new
  def new
    # If user already has an active meeting, find it based on cookies.
    if cookies['current_meeting']
      @meeting = Meeting.find_by_hashkey(cookies['current_meeting'])
      if @meeting
        redirect_to(@meeting)
      end
    end
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.parse_phone_number
    @meeting.create_hashkey

    respond_to do |format|
      if @meeting.save
        cookies['current_meeting'] = @meeting.hashkey
        # Runs send_notification once the timer runs out
        @meeting.delay(run_at: @meeting.time_to_live.minutes.from_now).send_notification
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to new_meeting_path, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /meetings/meeting_ok/
  def meeting_ok
      @meeting = Meeting.find_by_hashkey(cookies['current_meeting'])
      if @meeting
        @meeting.destroy
        cookies.delete 'current_meeting'
      end
      redirect_to root_path
  end


  # POST /meetings/send_alert/
  def send_alert
    @meeting = Meeting.find_by_hashkey(cookies['current_meeting'])
    if @meeting
      @meeting.send_alert
      redirect_to :meetings_alert_confirm
    else
      cookies.delete 'current_meeting'
      redirect_to root_path
    end
  end

  # GET /meetings/id
  def exists
    if Meeting.exists?(id: params[:id])
      msg = {:meeting_exists => true}
      render :json => msg
    else
      msg = {:meeting_exists => false}
      render :json => msg
    end
  end

  # GET /meetings/alert_confirm
  def alert_confirm
    @meeting = Meeting.find_by_hashkey(cookies['current_meeting'])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:nickname, :phone_number, :duration, :confirmed, :latitude, :longitude)
    end

    def delete_job(hashkey)
      jobs = Delayed::Job.all
      jobs.each do |job|
        #If the meeting's hashkey is mentioned at some point
        if job.handler.match(hashkey)
          job.delete
        end
      end
    end

end
