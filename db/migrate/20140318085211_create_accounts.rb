class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.float :current_balance
      t.string :account_type
      t.float :monthly_account_rate
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end
