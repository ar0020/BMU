class CustomerController < ApplicationController

  def create
    @user = User.find(params[:id])
    @user.update_attribute :user_level, 3
  end
end
