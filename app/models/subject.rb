class Subject < ApplicationRecord
    validates :name, uniqueness: true
end
