class CustomerController < ApplicationController

  def create
    @user = User.find(params[:id])
    @user.update_attribute :user_level, 3
    redirect_to user_show_path(@user)
  end
end
