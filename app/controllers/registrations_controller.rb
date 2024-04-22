# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :availability, :update_availability]

  def update_availability
    updated_availability = availability_params[:availability].deep_dup
    
    updated_availability.each do |day, slots|
      slots.each_with_index do |slot, index|
        if slot == 'false' && slots[index + 1] == 'true'
          slots.delete_at(index)
        end
      end
    end

    if current_user.update(availability: updated_availability)
      flash[:notice] = "Availability updated successfully"
    else
      flash[:error] = "Failed to update availability"
    end
    redirect_to user_availability_path
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role, :availability, section_ids: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:availability, section_ids: []])
  end

  def availability_params
    params.require(:user).permit(availability: {})
  end
end
