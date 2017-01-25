class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :nickname
      t.string :phone_number
      t.integer :duration
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
