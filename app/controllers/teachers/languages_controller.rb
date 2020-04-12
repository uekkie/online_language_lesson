class Teachers::LanguagesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_language, only: %i[edit update destroy]

  def index
    @teacher_languages = current_teacher.teacher_languages
  end

  def new
    @language = Language.new
  end

  def edit
  end

  def create
    language = Language.new(language_params)
    @teacher_language = current_teacher.teacher_languages.build(language: language)

    if @teacher_language.save
      redirect_to profile_teachers_url, notice: "#{language.name}を追加しました"
    else
      render :new
    end
  end

  def destroy
    @teacher_language.destroy!
    redirect_to profile_teachers_url, alert: "#{@teacher_language.language.name}を削除しました"
  end

  private

  def set_language
    @teacher_language = current_teacher.teacher_languages.find(params[:id])
  end

  def language_params
    params.require(:language).permit(:name)
  end

end
