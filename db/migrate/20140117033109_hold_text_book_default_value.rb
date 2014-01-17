class HoldTextBookDefaultValue < ActiveRecord::Migration
  def change
    
    change_column :advertisements, :hold_textbook, :boolean, :default => false
    Advertisement.reset_column_information
    Advertisement.update_all(hold_textbook: false)
  end
end
