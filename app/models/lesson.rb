class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :city
    belongs_to :user
    belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
    belongs_to :subject
end
