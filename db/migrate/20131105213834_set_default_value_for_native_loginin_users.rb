class SetDefaultValueForNativeLogininUsers < ActiveRecord::Migration
  def change
    change_column :users, :nativelogin, :boolean, :default => true
     
    User.reset_column_information
    User.update_all(nativelogin: true)
  end
end
