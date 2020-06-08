class Country < ApplicationRecord
    validates :name, uniqueness: true, length: { minimum:1}
    validates :cod, uniqueness: true, length: { minimum:1}
    has_many :cities 
end
