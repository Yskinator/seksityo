module UserHelper
  @@credits_enabled = true

  def decrease_credits
    if @@credits_enabled
      @user = User.find_by_code(cookies[:ucd])
      @user.decrement!(:credits)
    end
  end

  def increment_credits
    if @@credits_enabled
      @user = User.find_by_code(cookies[:ucd])
      @user.increment!(:credits)
    end
  end

  # Validates that the user exists and has credits
  def validate_user
    unless @@credits_enabled
      return true
    end
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
    unless @@credits_enabled
      return true
    end
    @user = User.find_by_code(cookies[:ucd])
    if @user.credits > 0
      return true
    else
      return false
    end
  end
  def user_exists
    unless @@credits_enabled
      return true
    end
    @user = User.find_by_code(cookies[:ucd])
    if @user
      return true
    else
      return false
    end
  end
end
