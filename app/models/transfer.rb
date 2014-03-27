class Transfer < Transaction
  attr_accessor :to_account_id, :from_account_id

  def transfer
    @to_account = Account.find(param[self.to_account_id])
    @from_account = Account.find(param[self.from_account_id])


      Withdrawal.transaction do
        self.save!
        @to_account.save!
        @from_account.save!
      end
  end

end
