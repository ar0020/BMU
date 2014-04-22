class Market < Account
  
  validates :monthly_account_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
  
  def rate
    #intrest = self.current_balance * self.monthly_account_rate
    #intrest = self.current_balance + intrest
    #self.update_attribute(:current_balance, intrest)
    ActiveRecord::Base.connection.execute(%{
      UPDATE accounts
        SET current_balance = current_balance + (current_balance * monthly_account_rate)
        WHERE account_type = 'Market'     
    })
  end

  private

  def set_type
    self.account_type = "Market"
  end
end
