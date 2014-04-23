require 'openssl'
require 'digest/sha1'

class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
		 
	validate :user_level, presence: true, numericality: { only_integer: true, :greater_than=>0, :less_than=>4, :message=>" is an invalid level." }
  validates :username,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => %r{[a-zA-Z0-9]} # etc.
    
  attr_accessor :login, :level, :encrypted_login
  
  has_many :accounts
    
	LEVELS=[[1,"Administrator"],[2,"Teller"],[3,"Customer"]]
	
	# Search function for User table.
  def users
    results = User.limit(50)
    #tmp_user = User.new(username: self.username, email: self.email, id: self.id, user_level: self.user_level)
    if self.username != ''
      self.encrypt_username
      results = results.where(username: self.username)
    end 
    results = results.where(email: self.email) unless self.email == ''
    results = results.where(id: self.id) unless self.id.nil?
    results = results.where(user_level: self.user_level) unless self.user_level.nil?
    return results
  end
	

  def display_account_id
    number = "#{self.id}"
    number = "%.8i" % number
    last_4 = number[number.length - 4, 4]
    first_4 = number[0, 4]
    return "#{first_4}-#{last_4}"
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
  
  
  #### This is the correct method you override with the code above
  #### def self.find_for_database_authentication(warden_conditions)
  #### end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      user = User.new(username: login)
      user.encrypt_username
      where(conditions).where(["username = ?", user.username ]).first
    else
      where(conditions).first
    end
  end
  
  def email_required?
    false
  end
  
  def email_changed?
    false
  end
  
  before_validation :encrypt_username
  
  def encrypt_username
    cipher = Cipher.new  ["K", "D", "w", "X", "H", "3", "e", "1", "S", "B", "g", "a", "y", "v", "I", "6", "u", "W", "C", "0", "9", "b", "z", "T", "A", "q", "U", "4", "O", "o", "E", "N", "r", "n", "m", "d", "k", "x", "P", "t", "R", "s", "J", "L", "f", "h", "Z", "j", "Y", "5", "7", "l", "p", "c", "2", "8", "M", "V", "G", "i", " ", "Q", "F"]
    crypted = cipher.encrypt self.username
    self.username = crypted
  end
  
  def display_username
    cipher = Cipher.new  ["K", "D", "w", "X", "H", "3", "e", "1", "S", "B", "g", "a", "y", "v", "I", "6", "u", "W", "C", "0", "9", "b", "z", "T", "A", "q", "U", "4", "O", "o", "E", "N", "r", "n", "m", "d", "k", "x", "P", "t", "R", "s", "J", "L", "f", "h", "Z", "j", "Y", "5", "7", "l", "p", "c", "2", "8", "M", "V", "G", "i", " ", "Q", "F"]
    decrypted = cipher.decrypt self.username
    return decrypted
  end
end
