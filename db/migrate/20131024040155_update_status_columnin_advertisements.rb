class UpdateStatusColumninAdvertisements < ActiveRecord::Migration
  def change
    Advertisement.reset_column_information
    Advertisement.update_all(status: true)
  end
end
