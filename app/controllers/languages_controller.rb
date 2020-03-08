class LanguagesController < ApplicationController
  before_action :set_language, only: %i[show]

  def index
    @languages = Language.all.order(:name)
  end

  def show

  end

  private

  def set_language
    @language = Language.find(params[:id])
  end
end
