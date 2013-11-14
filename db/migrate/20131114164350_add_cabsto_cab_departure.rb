class AddCabstoCabDeparture < ActiveRecord::Migration
  def change
    add_column :cab_departures, :cab_share_id, :integer
    
    create_table :cab_shares do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.datetime :time
      t.timestamps
    end
  end
end
