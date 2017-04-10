class UsersController < ApplicationController
  # POST /users/
  def create_or_find
    @user = User.find_by_phone_number(params[:phone_number])

    if !@user
      cookies.delete 'code'
      @user = User.new
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
  end

end