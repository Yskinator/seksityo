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

  # PATCH/PUT /users/1.json
  def update
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/admin', notice: 'Credits were successfully edited.' }
        format.json { render 'admins/index', status: :ok}
      else
        format.html { redirect_to admin_path}
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:code, :phone_number, :credits)
  end


end