class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  def accounts(offset)
    @accounts = Account.find(offset)
  end

  def rate
  end

end
