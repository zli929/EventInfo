class AddingAdComments < ActiveRecord::Migration
  def change
    create_table :advertisement_comments do |t|
      t.integer   :user_id
      t.integer   :advertisement_id
      t.string    :comment
      
      t.timestamps
    end
  end
end
