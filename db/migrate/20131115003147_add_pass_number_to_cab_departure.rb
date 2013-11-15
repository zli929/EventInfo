class AddPassNumberToCabDeparture < ActiveRecord::Migration
  def change
    add_column :cab_departures, :party_size, :integer
    add_column :cab_shares, :party_size, :integer
  end
end
