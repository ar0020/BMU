class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  validates :user_id, :account_id, :payee_name, :payee_street, :payee_city, :payee_state, :payee_zip, :payee_account_id, :amount, :pay_date, preseces: true

end
