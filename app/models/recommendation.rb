class Recommendation < ApplicationRecord
  belongs_to :course
  validate :student_email_exists

  private

  def student_email_exists
    unless User.exists?(email: student_email)
      errors.add(:student_email, "does not exist")
    end
  end
end
