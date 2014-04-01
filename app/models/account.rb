class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

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

  def rate
  end

  def numeric_ending
    number = "#{self.id}"
    number = "%.8i" % number
    last_four = number[number.length - 4, 4]
    return last_four
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
