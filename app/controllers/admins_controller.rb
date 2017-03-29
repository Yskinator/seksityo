class AdminsController < ApplicationController
  helper_method :stat_sort_column, :stat_sort_direction, :meeting_sort_column, :meeting_sort_direction
  before_action :authenticate

  def index
    # Fetch column name and direction from the parameters and pass them to order method.
    @statistics = Stat.order(stat_sort_column + " " + stat_sort_direction)
    @meetings = Meeting.order(meeting_sort_column + " " + meeting_sort_direction)

    render 'admins/index'
  end

  def destroy
    if @meeting = Meeting.find_by_id(params[:id])
      @meeting.destroy
      flash[:notify] = "Meeting deleted succesfully"
      redirect_to :back
    else
      flash[:notify] = "Failed to delete meeting"
      redirect_to :back
    end
  end


  private

  # Methods for fetching sort-related parameters
  # Only accept column name that exists for Stat. Default to country_code
  def stat_sort_column
    Stat.column_names.include?(params[:stat_sort]) ? params[:stat_sort] : "country_code"
  end
  # Only accept "asc" or "desc" as params for direction. Default to "asc".
  def stat_sort_direction
    %w[asc desc].include?(params[:stat_direction]) ? params[:stat_direction] : "asc"
  end

  def meeting_sort_column
    Meeting.column_names.include?(params[:meeting_sort]) ? params[:meeting_sort] : "created_at"
  end

  def meeting_sort_direction
    %w[asc desc].include?(params[:meeting_direction]) ? params[:meeting_direction] : "desc"
  end

  protected

  # Authentication using HTTP BASIC authentication
  def authenticate
    # Set user to nil
    user = nil
    # Try authenticating with supplied username and password
    authenticate_or_request_with_http_basic do |username, password|
      user = User.find_by(username: username).try(:authenticate, password)
    end
    # If authentication fails, user is nil and authentication is requested from the user.
    if user.nil?
      request_http_basic_authentication
    end
  end
end
