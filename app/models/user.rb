class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
		 
	attr_accessor :login, :level
	
	#def self.user(id)
	#  return User.where(:id=>id).first
	#end
	
	# Search function for User table.
	def self.users(user)
    results = User.limit(50)
	  results = results.where("users.username LIKE ?", user.username) unless user.username =''
    results = results.where("users.email LIKE ?", user.email) unless user.email =''
    results = results.where("users.id = ?", user.id) unless user.id =''
	  return results
	end
	
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
	
	# a user should not be able to cheat their user_level
	#attr_accessible :user_level
  
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  #### This is the correct method you override with the code above
  #### def self.find_for_database_authentication(warden_conditions)
  #### end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  validates :username,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => %r{[a-zA-Z0-9]} # etc.
  
  def email_required?
    false
  end
  
  def email_changed?
    false
  end
end
