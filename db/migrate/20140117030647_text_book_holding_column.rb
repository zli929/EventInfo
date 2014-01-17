class TextBookHoldingColumn < ActiveRecord::Migration
  def change
    add_column :advertisements, :hold_textbook, :boolean
    Advertisement.reset_column_information
    Advertisement.update_all(hold_textbook: false)
  end
end
