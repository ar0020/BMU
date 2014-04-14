class Market < Account
  def rate
    intrest = self.current_balance * self.monthly_account_rate
    intrest = self.current_balance + intrest
    self.update_attribute(:current_balance, intrest)
  end

  private

  def set_type
    self.account_type = "Market"
  end
end
