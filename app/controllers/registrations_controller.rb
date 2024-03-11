# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  
    protected
  
    def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
    end
end
  