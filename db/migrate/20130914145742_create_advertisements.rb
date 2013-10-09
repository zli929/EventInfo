class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :user_id
      t.text :content
      t.float :price
      
      t.timestamps
    end
  end
end
