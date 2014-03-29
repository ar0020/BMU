class Checking < Account
  def rate
  end
  
  private
  
  def set_type
    self.account_type = "Checking"
  end
end
