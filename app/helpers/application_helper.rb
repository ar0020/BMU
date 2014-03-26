module ApplicationHelper
  # Check if logged in user is an admin
  def admin?
    if current_user.user_level == 1
      return true
    end
    return false
  end
  
  def teller?
    if current_user.user_level == 2
      return true
    end
    return false
  end
  
  def customer?
    if current_user.user_level == 3
      return true
    end
    return false
  end
end
