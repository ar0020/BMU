class CustomerController < ApplicationController

  def index
    if (admin? || teller?) && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @accounts = Account.where(user_id: @user.id)

    # This should then find all bills that are recurring and display them.
    # no idea if this works....

    
    @bills = Bill.where(user_id: @user.id).
                  where("(pay_date >= :pay_date AND is_recurring = :not_recurring)
                         OR
                         is_recurring = :is_recurring
                        ", pay_date: Date.today, not_recurring: false, is_recurring: true)
  end
end
