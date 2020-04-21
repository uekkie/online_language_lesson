module ApplicationHelper

  def not_signed_in?
    !(user_signed_in? || teacher_signed_in?)
  end

  def masquerade_signed_in?
    session[:admin_id].present?
  end

end
