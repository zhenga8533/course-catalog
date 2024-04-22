class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def dashboard
    @unverified_users = if params[:search_email].present?
                          User.where(verified: false).where("email LIKE ?", "%#{params[:search_email]}%")
                        else
                          User.where(verified: false)
                        end
  end

  def verify_user
    user = User.find(params[:id])
    user.update(verified: true)
    redirect_to dashboard_path, notice: "User #{user.email} has been verified."
  end

  private

  def ensure_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
