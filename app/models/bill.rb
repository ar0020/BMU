class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :payee_account, class_name: "Account"
  validates :user, :account, :payee_name, :payee_street, 
            :payee_city, :payee_state, :payee_zip, :payee_account, 
            :amount_string, :amount, :pay_date, presence: true
  validates_associated :user, :account, :payee_account
  validates :amount_string, format: { 
            with: /(?=.)^\$?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+)?(\.[0-9]{1,2})?$/,
            message: " is invalid.",
            multiline: true}
  validates :payee_zip, length: { is: 5, wrong_length: " should be 5 numbers long."}
  validates :payee_zip, numericality: { only_integer: true }
  validate :custom_validation?
  attr_accessor :amount_string
  before_validation :convert_amount

  def bills(offset)
    @bills = Bill.find(offset)
  end
  
  def custom_validation?
    account = Account.find(self.account_id)
    errors.add(:account_id, " must not be from a Mortgage, Market, or Savings account.") if account.account_type != "Checking" && account.account_type != "Credit" 
    errors.add(:account_id, " must be one of you own.") if account.user_id != self.user_id
    errors.add(:pay_date, " can't be in the past.") if self.pay_date < Date.yesterday
    errors.add(:pay_date, " can not be past the 28th of the month.") if self.pay_date.day > 28
  end
  
  def convert_amount
    match = ""
    for i in self.amount_string.scan(/\d\.*/)
      match += i
    end
    self.amount = match.to_f
  end
end
