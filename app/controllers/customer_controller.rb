class CustomerController < ApplicationController

  def index
    if admin? || teller?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @accounts = Account.where(:user_id => @user.id)
  end
end
