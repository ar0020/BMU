class AddUserLevelsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_level, :int
  end
end
