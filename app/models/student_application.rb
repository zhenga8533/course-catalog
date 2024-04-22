class StudentApplication < ApplicationRecord
  # Associations
  belongs_to :user
  has_and_belongs_to_many :courses

  # Validations
  validates :user_id, :contact_info, :status, :course_id, presence: true
  validates :status, inclusion: { in: %w[pending approved denied] }
  validates :preferences_in_grading_assignments, length: { maximum: 500 }, allow_blank: true

  # Callbacks
  after_initialize :init_values

  private

  # Sets initial values for 'status'
  def init_values
    self.status ||= 'pending'
  end
end