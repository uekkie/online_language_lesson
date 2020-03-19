module ApplicationHelper

  def masquerade_signed_in?
    session[:admin_id].present?
  end

end
