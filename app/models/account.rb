class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  validates :user, :account_type, :balance_string, :current_balance,
            :account_type, :monthly_account_rate, :is_active, presence: true

  validates :balance_string, format: {
            with: /(?=.)^\$?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+)?(\.[0-9]{1,2})?$/,
            message: " is invalid.",
            multiline: true}

  validates :account_type, format: {
            with: /(Credit|Checking|Mortgage|Market|Saving)/
            }

  before_validation :convert_amount
  before_validation :set_type
  before_save :check_if_customer
  attr_accessor :username, :balance_string

  TYPES=["Checking","Credit","Market","Mortgage","Saving"]

  def self.accounts(account)
    accounts = Account.limit(50)
    accounts = accounts.where("accounts.user_id = ?", account.user_id) unless account.user_id.nil?
    accounts = accounts.where(id: account.id) unless account.id.nil?
    #accounts = accounts.where(users: {username: account.username}).joins(:user) unless account.username.empty?
    accounts = accounts.where(account_type: account.account_type) unless account.account_type.empty?
    accounts = accounts.where(monthly_account_rate: account.monthly_account_rate) unless account.monthly_account_rate.nil?
    return accounts
  end

  def rate
  end

  def display_account_id
    number = "#{self.id}"
    number = "%.8i" % number
    last_4 = number[number.length - 4, 4]
    first_4 = number[0, 4]
    return "#{first_4}-#{last_4}"
  end

  def display_account_ending
    number = "#{self.id}"
    number = "%.8i" % number
    last_4 = number[number.length - 4, 4]
    return last_4
  end

  def convert_amount
    if self.balance_string
      match = ""
      for i in self.balance_string.scan(/\d\.*/)
        match += i
      end
      self.current_balance = match.to_f
    end
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
    self.is_active = true
    # Blank here, but the 5 subclasses use this function to set their account_type appropriately.
  end

end
