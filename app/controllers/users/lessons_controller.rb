class Users::LessonsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lessons = Lesson.latest
  end
end
