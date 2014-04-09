class AddUserLevelsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_level, :integer #short was undefined in sqlite3
  end
end
