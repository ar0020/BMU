class User < ActiveRecord::Base		
  has_many :accounts 
  has_secure_password
	validates :user_level, presence: true, numericality: { only_integer: true, :greater_than=>0, :less_than=>4, :message=>" is an invalid level." }
  validates :username,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => %r{[a-zA-Z0-9]} # etc
  
  validates_presence_of :password, :on => :create
  validates_presence_of :email
    
	# Humanizes user_level for readability
	def level
    if self.user_level == 1
      level= "Admin"
    elsif self.user_level == 2
      level= "Teller"
    elsif self.user_level == 3
      level= "Customer"
    else
      level= "NO LEVEL!"
    end
	end
end
