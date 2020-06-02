class City < ApplicationRecord
    validates :name, uniqueness: true
    belongs_to :country
end
