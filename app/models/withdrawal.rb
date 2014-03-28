class Withdrawal < Transaction
  belongs_to :user
  belongs_to :account
  validates :user_id, :amount, :transaction_type, :account_id, presence: true
  validates :amount, :numericality => {:greater_than => 0}
  validates_associated :user_id, :account_id

  def withdrawal
    self.transaction_type = "Withdrawal"
    self.amount = self.amount.abs # make sure amount is positive
    self.amount = '%.2f' % self.amount # rounds to two digits.
    
    account = Account.find(self.account_id)
    new_balance = account.current_balance - self.amount
    
    # Validates that the user_id entered is a valid id.
    user = User.find(self.user_id)
    # Validates that user either owns the account or the user is a teller.
    # Validates this is an active account.
    # Validates that this type of account can be withdrawn from.
    if (user.id != account.user_id && user.user_level != 2) || !account.is_active? || validate_transaction_on_account?
      return false
    end
    if user.user_level == 2
      self.description = "Withdrawal from teller."
    end
    Withdrawal.transaction do
      Account.transaction do
        self.save!
        account.update_attribute(:current_balance, new_balance)
        raise ActiveRecord::Rollback unless self.valid? && account.valid?
      end
    end
    
    return true
  end
end
