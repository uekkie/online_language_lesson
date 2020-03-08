class Languages::LessonsController < ApplicationController
  before_action :set_language

  def index
    @lessons = @language.lessons
  end

  private

  def set_language
    @language = Language.find(params[:language_id])
  end
end
