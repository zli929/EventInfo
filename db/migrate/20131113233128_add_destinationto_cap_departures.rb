class AddDestinationtoCapDepartures < ActiveRecord::Migration
  def change
    add_column :cab_departures, :destination, :string
  end
end
