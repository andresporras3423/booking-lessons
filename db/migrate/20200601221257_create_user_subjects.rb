# frozen_string_literal: true

class CreateUserSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :user_subjects do |t|
      t.integer :user_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
