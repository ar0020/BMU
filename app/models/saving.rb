class Saving < Account

  def rate
    intrest = self.current_balance * self.monthly_account_rate
    self.current_balance += intrest
    self.save!
  end

  private
  
  def set_type
    self.account_type = "Saving"
  end
end
