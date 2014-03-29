class ChangePayDateTypeInBills < ActiveRecord::Migration
  def change
    change_column :bills, :pay_date, :date
  end
end
