class AddCountryToStats < ActiveRecord::Migration
  def change
    add_column :stats, :country, :string
  end
end
