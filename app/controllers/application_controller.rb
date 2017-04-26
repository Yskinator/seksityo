class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :authenticate, :set_locale

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

  def set_locale
    @showChangeLink = true
    @changeLinkText = ''

    if cookies['lang'] == 'en'
      I18n.locale = 'en'
      @changeLinkText = I18n.t :language_selector, locale: http_accept_language.compatible_language_from(I18n.available_locales)
    else
      if http_accept_language.compatible_language_from(I18n.available_locales).nil?
        I18n.locale = I18n.default_locale
        @showChangeLink = false;
      else
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
      end

      @changeLinkText = I18n.t :language_selector, locale: :en
    end

    # Get the preferred locale
    preferred_locale_string = http_accept_language.compatible_language_from(http_accept_language.user_preferred_languages)
    # If users preferred language is "en" or some subset of "en", dont show the language selector
    if /^en$/ =~ preferred_locale_string || /^en-/ =~ preferred_locale_string
      @showChangeLink = false;
    else

    end

  end

end
