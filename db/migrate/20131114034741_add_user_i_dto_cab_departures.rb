class AddUserIDtoCabDepartures < ActiveRecord::Migration
  def change
    add_column :cab_departures, :user_id, :integer
  end
end
