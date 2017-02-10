class AddLatitudeAndLongitudeToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :latitude, :string
    add_column :meetings, :longitude, :string
  end
end
