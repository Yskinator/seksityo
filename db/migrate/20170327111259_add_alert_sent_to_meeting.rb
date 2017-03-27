class AddAlertSentToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :alert_sent, :boolean
  end
end
