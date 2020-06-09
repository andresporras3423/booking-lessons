# frozen_string_literal: true

class AddCityToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :city_id, :integer
  end
end
