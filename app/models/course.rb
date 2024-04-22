class Course < ApplicationRecord
    validates :term, :title, :description, :subject, :catalog_number, :campus, :course_id, presence: true
    has_many :sections, dependent: :destroy
    has_many :recommendations, dependent: :destroy
end