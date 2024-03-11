class AdminsController < ApplicationController
  before_action :ensure_admin

  def unverified_users
    @unverified_users = User.where(verified: false)
  end

  def verify_user
    user = User.find(params[:id])
    user.update(verified: true)
    redirect_to unverified_users_path, notice: "User #{user.email} has been verified."
  end

  private

  def ensure_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
