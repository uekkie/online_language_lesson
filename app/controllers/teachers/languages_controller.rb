class Teachers::LanguagesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_language, only: %i[edit update destroy]

  def index
    @languages = current_teacher.languages.recent
  end

  def new
    @language = current_teacher.languages.build
  end

  def edit
  end

  def create
    @language = current_teacher.languages.build(language_params)

    if @language.save
      redirect_to teachers_languages_url, notice: "#{@language.name}を追加しました"
    else
      render :new
    end
  end

  def update
    if @language.update(language_params)
      redirect_to teachers_languages_url, notice: "#{@language.name}を変更しました"
    else
      render :edit
    end
  end

  def destroy
    @language.destroy!
    redirect_to teachers_languages_url, alert: "#{@language.name}を削除しました"
  end

  private

  def set_language
    @language = current_teacher.languages.find(params[:id])
  end

  def language_params
    params.require(:language).permit(:name)
  end

end
