module UserHelper
  @credits_enabled = false

  # This check happens before every method
  # Returns true so that validate_user always returns true when credits are disabled
  def self.included(base)
    unless @credits_enabled
      return true
    end
  end

  def decrease_credits
    @user = User.find_by_code(cookies[:ucd])
    @user.credits -= 1
    @user.save
  end

  def increment_credits
    @user = User.find_by_code(cookies[:ucd])
    @user.credits += 1
    @user.save
  end

  # Validates that the user exists and has credits
  def validate_user
    unless user_exists
      redirect_to users_path
      return
    end
    unless user_has_credits
      redirect_to credits_path
      return
    end
  end

  def user_has_credits
    @user = User.find_by_code(cookies[:ucd])
    if @user.credits > 0
      return true
    else
      return false
    end
  end
  def user_exists
    @user = User.find_by_code(cookies[:ucd])
    if @user
      return true
    else
      return false
    end
  end
end
