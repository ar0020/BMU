class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :account_id
      t.float :amount
      t.string :transaction_type
      t.string :description

      t.timestamps
    end
  end
end
