class UsersController < ApplicationController

  def code_generation
    @user = nil

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
    return @user.code
  end

  def cookie_recovery_link
    @recovery_link = ''
    if params['phone_number']
      @user = User.find_by_phone_number(params['phone_number'])
      if @user
        @recovery_link = request.base_url  + "/users/id=" + @user.code
      end
    end
  end

  def recover_cookie
    if params['id']
      if(User.find_by_code(params['id']))
        cookies['code'] = params['id']
      end
      redirect_to :root
    else
      puts "Bad URL"
      redirect_to :root
    end
  end
end
