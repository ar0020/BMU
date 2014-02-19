class AddAdminAndTellerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :teller, :bool
    add_column :users, :admin, :bool
  end
end
