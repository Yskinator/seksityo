class CreateSecondUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :code
      t.integer :credits

      t.timestamps null: false
    end
  end
end
