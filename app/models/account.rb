class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
        #params.require(:account).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)

  validates :user_id, :account_type, :current_balance, :account_type, :monthly_account_rate, :is_active, presence: true

  TYPES=["Checking","Credit","Market","Mortgage","Regular"]

  def accounts(offset)
    @accounts = Account.find(offset)
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

end
