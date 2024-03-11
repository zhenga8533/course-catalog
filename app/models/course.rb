class Course < ApplicationRecord
    has_many :sections, dependent: :destroy
end