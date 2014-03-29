class Mortgage < Account
  def rate
  end
  
  private
  
  def set_type
    self.account_type = "Mortgage"
  end
end
