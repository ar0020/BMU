class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  validates :amount, :numericality => {:greater_than => 0}
  #validates_associated :user, :account
  validates :user, :amount_string, :amount, :transaction_type, :account, presence: true

  validates :amount_string, format: {
            with: /\A(?=.)^\$?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+)?(\.[0-9]{1,2})?$\z/,
            message: " is invalid.",
            multiline: true}

  before_validation :convert_amount

  attr_accessor :amount_string

  MORTGAGE = ["Deposit"]
  CHECKING = ["Deposit", "Withdrawal", "Transfer"]
  CREDIT   = ["Deposit", "Withdrawal", "Transfer"]
  MARKET   = ["Deposit", "Withdrawal"]
  SAVING   = ["Deposit", "Withdrawal"]

  def self.transactions(account_id)
    results = Transaction.limit(50)
    results = results.where(account_id: account_id)
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


  def convert_amount
    match = ""
    for i in self.amount_string.scan(/\d\.*/)
      match += i
    end
    self.amount = match.to_f
  end

  def short_hand_type
    return("DEPO") if self.transaction_type == "Deposit"
    return("WITH") if self.transaction_type == "Withdrawal"
    return("XFER") if self.transaction_type == "Transfer"
  end
end
