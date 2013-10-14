class AddPennEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :network_email, :string
  end
end
