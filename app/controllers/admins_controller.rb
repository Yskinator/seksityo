class AdminsController < ApplicationController
  before_action :authenticate

  def index
    @meetings = Meeting.all
    @statistics = Stat.all
    render 'admins/index'
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
