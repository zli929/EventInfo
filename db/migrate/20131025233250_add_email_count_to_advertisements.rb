class AddEmailCountToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :email_count, :integer
  end
end
