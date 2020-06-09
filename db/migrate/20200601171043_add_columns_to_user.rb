# frozen_string_literal: true

class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :city_id, :integer
    add_column :users, :role_id, :integer
  end
end
