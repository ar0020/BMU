class CustomerController < ApplicationController

  def index
    if (admin? || teller?) && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @accounts = Account.where(:user_id => @user.id)

    # This should then find all bills that are recurring and display them.
    # no idea if this works....
    if @accounts.each do |account|
        @bills = Bill.where(" ? = ? AND pay_date >= ? OR is_recurring = ?", account.user_id, @user.id, Date.today.to_s, true)
      end
    else
      @bills = Bill.new
    end

  end
end
