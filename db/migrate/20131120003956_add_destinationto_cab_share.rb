class AddDestinationtoCabShare < ActiveRecord::Migration
  def change
    add_column :cab_shares, :destination, :string
      CabShare.reset_column_information
      CabShare.update_all(destination: 'Philadelphia International Airport')
  end
end
