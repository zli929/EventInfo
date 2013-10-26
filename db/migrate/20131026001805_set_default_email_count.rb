class SetDefaultEmailCount < ActiveRecord::Migration
  def change
    change_column :advertisements, :email_count, :integer, :default => 0
      Advertisement.reset_column_information
      Advertisement.update_all(email_count: 0)
  end
end
