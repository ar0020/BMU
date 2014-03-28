class Transaction < ActiveRecord::Base
  belongs_to :account
  
  def self.transactions(account_id)
    results = Transaction.limit(50)
    results = results.where("transactions.account_id = ?", account_id)
    return results
  end
end
