class User < ApplicationRecord
  has_many :grading_assignments
  has_many :sections, through: :grading_assignments
  
  after_initialize :initialize_availability

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

  def instructor?
    role == 'instructor' && verified
  end

  private

  def verify_account
    self.verified = role == 'student' || self.verified ? true : false
  end

  def initialize_availability
    self.availability ||= {}
    Date::DAYNAMES.each do |day|
      self.availability[day.downcase] ||= Array.new(48, "false")
    end
  end
end
