class Withdrawal < Transaction

  def withdrawal
    @account = Account.find(param[self.account_id])
    if @account.current_balance >= self.amount.abs
      @account.current_balance -= self.amount.abs
      Withdrawal.transaction do
        self.save!
        @account.save!
      end
    end
  end

end
