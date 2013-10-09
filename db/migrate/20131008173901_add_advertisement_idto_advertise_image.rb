class AddAdvertisementIdtoAdvertiseImage < ActiveRecord::Migration
  def change
    add_column :advertisement_images, :advertisement_id, :integer
  end
end
