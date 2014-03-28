class Transfer < Transaction
  attr_accessor :to_account_id, :from_account_id

  def transfer
    self.transaction_type = "Transfer"
    @transfer_to = self.dup
    @transfer_from = self.dup

    @transfer_to.account_id = self.to_account_id
    @transfer_from.account_id = self.from_account_id

    @to_account = Account.find(self.to_account_id)
    @from_account = Account.find(self.from_account_id)

    if teller? || (customer? && (@to_account.user_id == @from_account.user_id))
      @to_account.current_balance += self.amount
      @from_account.current_balance -= self.amount

      Withdrawal.transaction do
        @transfer_to.save!
        @transfer_from.save!
        @to_account.save!
        @from_account.save!
      end
      return true
    end
    #someone trying to access without correct user level
    return false
  end

end
