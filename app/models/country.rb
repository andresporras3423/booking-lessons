class Country < ApplicationRecord
    validates :name, uniqueness: true
    validates :cod, uniqueness: true
    has_many :cities
end
