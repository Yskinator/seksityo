class UsersController < ApplicationController
  # POST /users/
  def create_or_find
    @user = User.find_by_phone_number(user_params[:phone_number])
    if !@user
      cookies.delete 'code'
      @user = User.new(user_params)
      @user.parse_phone_number
      @user.create_code
      if @user.save
        cookies['code'] = @user.code
      end
      redirect_to root_path
    else
      redirect_to root_path
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