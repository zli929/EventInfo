class ChangeStatusColumninAdvertisements < ActiveRecord::Migration
  def change
    change_column :advertisements, :status, :boolean, :default => true
  end
end
