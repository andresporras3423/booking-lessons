class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.integer :tutor_id
      t.date :day
      t.integer :begin_hour
      t.integer :finish_hour

      t.timestamps
    end
  end
end
