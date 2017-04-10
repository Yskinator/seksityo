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

  def cookie_recovery_link(number)
    recovery_link = ''
    if number
      @user = User.find_by_phone_number(number)

      recovery_link = request.original_url + "/id=" + @user.code
    end
    return recovery_link
  end

  def recover_cookie
    if params['id']
      cookies['code'] = params['id']
      redirect_to '/meetings'
    else
      puts "Bad URL"
    end

  end
end
