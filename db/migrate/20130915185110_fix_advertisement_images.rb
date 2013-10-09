class FixAdvertisementImages < ActiveRecord::Migration
  def change
    remove_attachment :advertisements, :image
    add_attachment :advertisement_images, :image
  end
end
