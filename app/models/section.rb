class Section < ApplicationRecord
  has_many :grading_assignments
  has_many :users, through: :grading_assignments
  belongs_to :course

  validates :section_number, :component, :instruction_mode, :start_date, :end_date, presence: true
  validates :building_description, presence: true, allow_nil: true, allow_blank: true
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: { in: [true, false] }
  validates :section_number, numericality: { only_integer: true, greater_than: 0 }
  validates :start_time, :end_time, format: { with: /\A(?:1[012]|0?[1-9]):[0-5][0-9]\s?(?:am|pm)\z/i, message: "must be in the format HH:MM AM/PM" }, allow_nil: true, allow_blank: true
  validates :start_date, :end_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "must be in the format YYYY-MM-DD" }
end
