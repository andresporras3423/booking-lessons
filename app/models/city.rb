# frozen_string_literal: true

class City < ApplicationRecord
  validate :unique_city_country
  belongs_to :country
  validates :name, length: { minimum: 1 }

  def unique_city_country
    if City.all.any? { |c| c.name == name && c.country_id == country_id }
      errors.add(:base, message: 'city and country_id combination must be unique')
    end
  end
end
