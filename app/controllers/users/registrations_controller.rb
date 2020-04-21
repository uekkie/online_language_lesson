# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: %i[create]
   before_action :configure_account_update_params, only: %i[update]

  protected

  def configure_sign_up_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
