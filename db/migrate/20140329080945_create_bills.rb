class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :account_id
      t.boolean :is_recurring
      t.string :payee_name
      t.string :payee_street
      t.string :payee_city
      t.string :payee_state
      t.string :payee_zip
      t.integer :payee_account_id
      t.float :amount
      t.date :pay_date

      t.timestamps
    end
  end
end
