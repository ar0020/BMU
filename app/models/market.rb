class Market < Account
  def rate
  end
  
  private
  
  def set_type
    self.account_type = "Market"
  end
end
