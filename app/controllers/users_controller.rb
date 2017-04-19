class UsersController < ApplicationController
  before_action :authenticate, only: :update

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
    cookies.delete 'ucd'
    @user = User.new(user_params)
    if @user.save
      cookies['ucd'] = @user.code
    end
    redirect_to root_path
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
    @user = User.find_by_code(params['id'])

    if @user
      cookies.delete 'ucd'
      cookies['ucd'] = params['id']
    end
    redirect_to :root

  end


  # GET /users/
  def phone_form
    @user = User.new
  end


  # PATCH/PUT /users/1.json
  def update
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
        flash[:notify] = "User's credits changed successfully."
        format.html { redirect_to '/admin', notice: 'Credits were successfully edited.' }
        format.json { render 'admins/index', status: :ok}
      else
        flash[:notify] = "Failed to change user's credits."
        format.html { redirect_to '/admin'}
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:code, :phone_number, :credits)
  end


end
