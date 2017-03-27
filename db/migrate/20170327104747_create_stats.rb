class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :country_code
      t.integer :created
      t.integer :confirmed
      t.integer :alerts_sent
      t.integer :notifications_sent

      t.timestamps null: false
    end
  end
end
