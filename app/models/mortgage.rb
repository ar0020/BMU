class Mortgage < Account
  
  validates :monthly_account_rate, numericality: { greater_than_or_equal_to: 0}
  
  def rate
  end

  private

  def set_type
    self.account_type = "Mortgage"
  end
end
