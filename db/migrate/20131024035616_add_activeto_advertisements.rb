class AddActivetoAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :status, :boolean
  end
end
