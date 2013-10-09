class CreateAdvertisementImages < ActiveRecord::Migration
  def change
    create_table :advertisement_images do |t|\
      t.timestamps
    end
    
    add_attachment :advertisements, :image
  end
end
