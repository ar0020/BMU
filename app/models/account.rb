class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
        #params.require(:account).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)

  validates :user_id, :account_type, :current_balance, :account_type, :monthly_account_rate, :is_active, presence: true

  TYPES=["Checking","Credit","Market","Mortgage","Regular"]

  def accounts(offset)
    @accounts = Account.find(offset)
  end

  def rate
  end

end
