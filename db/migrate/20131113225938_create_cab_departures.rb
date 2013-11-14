class CreateCabDepartures < ActiveRecord::Migration
  def change
    create_table :cab_departures do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.float :location_buffer
      t.datetime :time
      t.float :time_buffer

      t.timestamps
    end
  end
end
