# frozen_string_literal: true

class Subject < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 1 }
end
