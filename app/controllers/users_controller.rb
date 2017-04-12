class UsersController < ApplicationController

  # POST /users/
  def receive_phone
    @user = User.find_by_phone_number(user_params[:phone_number])
    if !@user
      create_user
    else
      redirect_to root_path
    end
  end

  def create_user
    cookies.delete 'code'
    @user = User.new(user_params)
    if @user.save
      cookies['code'] = @user.code
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


  # GET /users/
  def phone_form
    @user = User.new
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:phone_number)
  end

end
