class Users::ReportsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_user

  def index
    @lessons = @user.lessons.latest
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
