class Deposit < Transaction
  def deposit
    @account = Account.find(self.account_id)
    self.transaction_type = "Deposit"
    if @account.is_active
      @account.current_balance += self.amount.abs
      Deposit.transaction do
        self.save!
        @account.save!
      end
      return true
    end
    return false
  end
end
