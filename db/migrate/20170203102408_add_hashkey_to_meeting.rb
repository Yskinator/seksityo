class AddHashkeyToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :hashkey, :string
  end
end
