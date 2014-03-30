class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :payee_account, class_name: "Account"
  validates :user, :account, :payee_name, :payee_street, 
            :payee_city, :payee_state, :payee_zip, :payee_account, 
            :amount, :pay_date, presence: true
  validates_associated :user, :account
  validates :amount, numericality: { with: /(?=.)^\$?(([1-9][0-9]{0,2}([0-9]{3})*)|[0-9]+)?(\.[0-9]{1,2})?$/,
            message: " must not contain commas, and no more than 2 places past a decimal point."}
  validates :payee_zip, length: { is: 5, wrong_length: " should be 5 numbers long."}
  validates :payee_zip, numericality: { only_integer: true }
  
  before_save :check_params


  def bills(offset)
    @bills = Bill.find(offset)
  end
  
  private
  
  def check_params
    account = Account.find(self.account_id)
    if account.user_id != self.user_id
      return false
    end
    return true
  end
end
