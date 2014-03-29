class Credit < Account
  validate :monthly_account_rate, presence: true, numericality: { :greater_than=>0, :message=>" is an invalid number." }
  
  def rate
  end
  
  private
  
  def set_type
    self.account_type = "Credit"
  end
end
