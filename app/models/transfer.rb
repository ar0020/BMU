class Transfer < Transaction
  attr_accessor :to_account_id, :from_account_id

  def self.transfer(to_transfer, from_transfer)
    to_transfer.transaction_type = "Transfer" if to_transfer.transaction_type.nil?
    from_transfer.transaction_type = "Transfer" if from_transfer.transaction_type.nil?
    # make sure amount is positive
    to_transfer.convert_amount
    from_transfer.convert_amount
    #to_transfer.amount = to_transfer.amount_string.to_f
    #from_transfer.amount = from_transfer.amount_string.to_f
    # round transfer amount
    to_transfer.amount = '%.2f' % to_transfer.amount
    from_transfer.amount = '%.2f' % from_transfer.amount
    # set transaction account_id column to correct value
    to_transfer.account_id = to_transfer.to_account_id
    from_transfer.account_id = from_transfer.from_account_id
    # find both
    to_account = Account.find(to_transfer.account_id)
    from_account = Account.find(from_transfer.account_id)
    # Validates that the user_id entered is valid.
    to_balance = to_account.current_balance + to_transfer.amount
    from_balance = from_account.current_balance - from_transfer.amount
    # Validates that the user_id entered is valid.
    user = User.find(from_transfer.user_id)
  # Validates that user either owns both accounts or the user is a teller.
    # Validates that this type of account can be withdrawn from.
    if (from_account.user_id != to_account.user_id && user.user_level != 2 && to_transfer.transaction_type != "Bill Deposit") ||
       (to_transfer.validate_transaction_on_account? && from_transfer.validate_transaction_on_account?) ||
       (to_transfer.account_id == from_transfer.account_id)
      return false
    end
    # Set description in database
    if user.user_level == 2
      to_transfer.description = "Transfer from teller."
      from_transfer.description = "Transfer from teller."
    end
    Transfer.transaction do
      Account.transaction do
        to_transfer.save!
        from_transfer.save!
        to_account.update_attribute(:current_balance, to_balance)
        from_account.update_attribute(:current_balance, from_balance)
        raise ActiveRecord::Rollback unless ((to_transfer.valid? && from_transfer.valid?) && (to_account.valid? && from_account.valid?))
      end
    end
    return true
  end
end
