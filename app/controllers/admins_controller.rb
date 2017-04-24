class AdminsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate

  def index
    # Fetch column name and direction from the parameters and pass them to order method.
    @statistics = Stat.order(stat_sort_column + " " + stat_sort_direction)

    # Either sort manually by time to live return value, or normally via column order.
    if meeting_sort_column == "time_to_live"
      @meetings = Meeting.all.sort { |a, b| a.time_to_live <=> b.time_to_live }
      if meeting_sort_direction == "desc"
        @meetings.reverse!
      end
    else
      @meetings = Meeting.order(meeting_sort_column + " " + meeting_sort_direction)
    end

    @users = User.all.order(user_sort_column + " " + user_sort_direction)

    render 'admins/index'
  end

  def destroy
    if @meeting = Meeting.find_by_id(params[:id])
      @meeting.destroy
      flash[:notify] = t('meeting_delete_success')
      redirect_to :back
    else
      flash[:notify] = t('meeting_delete_fail')
      redirect_to :back
    end
  end


  private

  # Methods for fetching sort-related parameters
  def sort_column model
    case model
    when 'stat'
      stat_sort_column
    when 'meeting'
      meeting_sort_column
    when 'user'
      user_sort_column
    end
  end

  def sort_direction model
    case model
    when 'stat'
      stat_sort_direction
    when 'meeting'
      meeting_sort_direction
    when 'user'
      user_sort_direction
    end
  end

  # Only accept column name that exists for Stat. Default to country_code
  def stat_sort_column
    Stat.column_names.include?(params[:stat_sort]) ? params[:stat_sort] : "country"
  end
  # Only accept "asc" or "desc" as params for direction. Default to "asc".
  def stat_sort_direction
    %w[asc desc].include?(params[:stat_direction]) ? params[:stat_direction] : "asc"
  end

  # Check if time to live, otherwise check if existing column name
  def meeting_sort_column
    if params[:meeting_sort] == "time_to_live"
      return "time_to_live"
    end
    Meeting.column_names.include?(params[:meeting_sort]) ? params[:meeting_sort] : "created_at"
  end

  def meeting_sort_direction
    %w[asc desc].include?(params[:meeting_direction]) ? params[:meeting_direction] : "desc"
  end

  def user_sort_column
    User.column_names.include?(params[:user_sort]) ? params[:user_sort] : "credits"
  end

  def user_sort_direction
    %w[asc desc].include?(params[:user_direction]) ? params[:user_direction] : "asc"
  end
  protected

end
