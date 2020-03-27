class Users::LessonsController < ApplicationController
  before_action :authenticate_user!

  def index
    @languages = Language.recent
    @lessons = Lesson.query_language(params[:language_id]).latest
  end
end
