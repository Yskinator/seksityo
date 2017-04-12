class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :authenticate

  # Authentication using HTTP BASIC authentication
  def authenticate
    # Set admin to nil
    admin = nil
    # Try authenticating with supplied username and password
    authenticate_or_request_with_http_basic do |username, password|
      admin = Admin.find_by(username: username).try(:authenticate, password)
    end
    # If authentication fails, admin is nil and authentication is requested from the user.
    if admin.nil?
      request_http_basic_authentication
    end
  end

end
