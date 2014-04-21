class Credit < Account
  
  validates :monthly_account_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}

  def rate
    #intrest = self.current_balance * self.monthly_account_rate
    #intrest = self.current_balance + intrest
    self.update_attribute(:current_balance, self.current_balance + (self.current_balance * self.monthly_account_rate) )
  end

  private

  def set_type
    self.account_type = "Credit"
  end
end
