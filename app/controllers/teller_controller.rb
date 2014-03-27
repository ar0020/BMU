class TellerController < ApplicationController

  def create
    @user = User.find(params[:id])
    @user.update_attribute :user_level, 2
    redirect_to user_show_path(@user)
  end

  def index
  end
end
