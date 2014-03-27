class Transaction < ActiveRecord::Base
  belongs_to :account
  def transactions(offset)

  end
end
