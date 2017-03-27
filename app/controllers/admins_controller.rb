class AdminsController < ApplicationController
  def index
    @meetings = Meeting.all
    render 'admins/index'
  end
end