# frozen_string_literal: true

class EditRole < ActiveRecord::Migration[6.0]
  def change
    add_column :roles, :description, :string
  end
end
