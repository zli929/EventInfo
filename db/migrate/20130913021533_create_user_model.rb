class CreateUserModel < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :salutation
      t.string   :first_name
      t.string   :last_name
      t.string   :email                   , :default => "",  :null => false
      t.string   :encrypted_password      , :default => "",  :null => false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.string   :remember_token
      t.datetime :remember_created_at
      t.string   :facebookuid
      t.boolean  :nativelogin
      t.integer  :sign_in_count           , :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.text     :profile
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      
      t.timestamps
    end
  end
end
