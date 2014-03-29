class Transfer < Transaction
  belongs_to :user
  belongs_to :account
  attr_accessor :to_account_id, :from_account_id
  validates :user_id, :amount, :transaction_type, :to_account_id, :from_account_id, presence: true
  validates :amount, :numericality => {:greater_than => 0}
  validates_associated :user_id, :account_id

  def transfer
    self.transaction_type = "Transfer"
    self.amount = self.amount.abs # make sure amount is positive and round
    # Find accounts * Throw exception if not found *
    to_account = Account.find(self.to_account_id)
    from_account = Account.find(self.from_account_id)
    # Create new balances for accounts
    to_balance = to_account.current_balance + self.amount
    from_balance = from_account.current_balance - self.amount
    # Validates that the user_id entered is valid.
    user = User.find(self.user_id)
    # Duplicate the transaction
    to_transfer = self.dup
    from_transfer = self.dup
    to_transfer.account_id = self.to_account_id
    from_transfer.account_id = self.from_account_id
    # Validates that user either owns both accounts or the user is a teller.
    # Validates that this type of account can be withdrawn from.
    if (from_account.user_id != to_account.user_id && user.user_level != 2) || (to_transfer.validate_transaction_on_account? && from_transfer.validate_transaction_on_account?)
      return false
    end
    if user.user_level == 2
      to_transfer.description = "Transfer from teller."
      from_transfer.description = "Transfer from teller."
    end
    Transfer.transaction do
      to_transfer.save!
      from_transfer.save!
      to_account.update_attribute(:current_balance, to_balance)
      from_account.update_attribute(:current_balance, from_balance)
      raise ActiveRecord::Rollback unless ((to_transfer.valid? && from_transfer.valid?) && (to_account.valid? && from_account.valid?))
    end
    return true
  end
end
