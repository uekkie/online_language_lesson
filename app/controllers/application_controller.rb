class ApplicationController < ActionController::Base
  private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Teacher)
      lessons_path
    else
      reservations_path
    end
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :teacher
      new_teacher_session_path
    else
      new_user_session_path
    end
  end
end
