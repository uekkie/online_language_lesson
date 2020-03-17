class ApplicationController < ActionController::Base
  private

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Teacher)
      teachers_lessons_path
    else
      users_reservations_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :teacher
      new_teacher_session_path
    else
      new_user_session_path
    end
  end
end
