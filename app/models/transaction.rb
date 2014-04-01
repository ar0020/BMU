class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  validates :amount, :numericality => {:greater_than => 0}
  validates_associated :user, :account
  validates :user_id, :amount, :transaction_type, :account_id, presence: true

  MORTGAGE = ["Deposit"]
  CHECKING = ["Deposit", "Withdrawal", "Transfer"]
  CREDIT   = ["Deposit", "Withdrawal", "Transfer"]
  MARKET   = ["Deposit", "Withdrawal"]
  SAVING   = ["Deposit", "Withdrawal"]

  def self.transactions(account_id)
    results = Transaction.limit(50)
    results = results.where("transactions.account_id = ?", account_id)
    return results
  end

  def validate_transaction_on_account?
    @account = Account.find(self.account_id)
    if @account.is_active?
      @account_type = @account.account_type
      if @account_type == "Mortgage" && MORTGAGE.find(self.transaction_type).any?
        return false
      elsif @account_type == "Checking" && CHECKING.find(self.transaction_type).any?
        return false
      elsif @account_type == "Credit" && CREDIT.find(self.transaction_type).any?
        return false
      elsif @account_type == "Market" && MARKET.find(self.transaction_type).any?
        return false
      elsif @account_type == "Saving" && SAVING.find(self.transaction_type).any?
        return false
      else
        return true
      end
    end
  end

end
