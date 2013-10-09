class AddTitletoAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :title, :string
  end
end
