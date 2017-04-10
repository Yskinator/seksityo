class UsersController < ApplicationController
  def code_generation
    if cookies['code']
      @user = User.find_by_code(cookies['code'])
    end

    if !@user
      cookies.delete 'code'
      @user = User.new
      @user.create_code
      if @user.save
        cookies['code'] = @user.code
      end
    end

    render 'users/code_generation'
  end

  def sms_sent
    @user = User.new
    @user.phone_number = 1231234
    @user.save
    render 'users/sms_sent'
  end
end