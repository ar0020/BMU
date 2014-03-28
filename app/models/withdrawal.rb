class Withdrawal < Transaction

  def withdrawal
    @account = Account.find(self.account_id)
    self.transaction_type = "Withdrawal"
    if @account.is_active
      @account.current_balance -= self.amount.abs
      Withdrawal.transaction do
        self.save!
        @account.save!
      end
      return true
    end
    return false
  end

end
