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
  def self.users(user)
    results = User.limit(50)
    results = results.where("users.username LIKE ?", user.username) unless user.username == ''
    results = results.where("users.email LIKE ?", user.email) unless user.email == ''
    results = results.where("users.id = ?", user.id) unless user.id.nil?
    results = results.where("users.user_level = ?", user.user_level) unless user.user_level.nil?
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
  

  def synchronous_encrypt_param2(param)
    sha256 = OpenSSL::Digest::SHA256.new
    sha256.digest(param)
    param.encode('UTF-8')
    return param
  end
  
  #### This is the correct method you override with the code above
  #### def self.find_for_database_authentication(warden_conditions)
  #### end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #login = synchronous_encrypt_param(login)
      sha256 = OpenSSL::Digest::SHA256.new
      sha256.digest(login)
      login.encode('UTF-8')
      where(conditions).where(["username = ?", login ]).first
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
    #self.username = synchronous_encrypt_param(self.username)
    name = self.username
    sha256 = OpenSSL::Digest::SHA256.new
    #name = sha256.digest(name)
    self.username = name.encode('UTF-8')
  end

  private
  
  def synchronous_encrypt_param2(param)
    # create the cipher for encrypting
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.encrypt
    
    # you will need to store these for later, in order to decrypt your data
    key = Digest::SHA1.hexdigest("supersecrethexdigestpasswordthatnoonewilleverknow")
    iv = cipher.random_iv
    
    # load them into the cipher
    cipher.key = key
    cipher.iv = iv
    
    # encrypt the message
    encrypted = cipher.update(param)
    encrypted << cipher.final
    #encrypted.sink.write(response[:data].force_encoding('ASCII-8BIT').encode('UTF-8'))
    return encrypted#.encode('UTF-8')
  end
end
