class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
        #params.require(:account).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)

  validates :user_id, :account_type, :current_balance, :account_type, :monthly_account_rate, :is_active, presence: true
  before_save :check_if_customer
  before_validation :set_type
  
  attr_accessor :username

  TYPES=["Checking","Credit","Market","Mortgage","Saving"]

  def self.accounts(account)
    accounts = Account.limit(50)
    accounts = accounts.where("accounts.user_id = ?", account.user_id) unless account.user_id.nil?
    accounts = accounts.where(id: account.id) unless account.id.nil?
    accounts = accounts.where(users: {username: account.username}).joins(:user) unless account.username.empty?
    accounts = accounts.where(account_type: account.account_type) unless account.account_type.empty?
    accounts = accounts.where(monthly_account_rate: account.monthly_account_rate) unless account.monthly_account_rate.nil?
    return accounts
  end

  def self.search(query)
    if query
      search_condition = "%" + query + "%"
      find(:all, :conditions => ["account_type LIKE ? OR user_id LIKE ?", search_condition, search_condition])
    else
      find(:all)
    end
  end

  def rate
  end
  
  private
  
  def check_if_customer
    user = User.find(self.user_id)
    if user.user_level == 3
      return true
    end
    return false
  end
  
  def set_type
    
  end
end
