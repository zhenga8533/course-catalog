# app/models/user.rb

class User < ApplicationRecord
  # Devise validations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom email format validation
  validates_format_of :email, with: /\A[\w+\-.]+(\.\w+)?\.[\w+]+@osu\.edu\z/i, message: "must be in the 'name.\#@osu.edu' format"

  # Verify all student account but not instructor/admin accounts
  before_create :verify_account

  def admin?
    role == 'admin' && verified
  end

  private

  def verify_account
    self.verified = role == 'student' || self.verified ? true : false
  end
end
