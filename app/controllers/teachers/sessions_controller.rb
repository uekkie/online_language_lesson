# frozen_string_literal: true

class Teachers::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_teacher!, only: %i[masquerade_sign_in]
  before_action :signed_in_admin, only: %i[masquerade_sign_in]

  def masquerade_sign_in
    teacher = Teacher.find(params[:id])
    session[:admin_id] = current_teacher.id
    bypass_sign_in(teacher)
    redirect_to root_url, notice: "#{teacher.name}として代理ログインしました"
  end


  def back_to_owner
    raise 'Failed. Masquerade signed in id not found.' unless session[:admin_id].present?
    admin = Teacher.find(session[:admin_id])
    bypass_sign_in(admin)
    session[:admin_id] = nil
    redirect_to root_url, notice: 'ログアウトしました'
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def signed_in_admin
    unless current_teacher.admin?
      redirect_to root_url, alert: 'この操作は管理者のみが実行できます'
    end
  end
end
