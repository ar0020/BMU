class TellerController < ApplicationController

  def create
    @user = User.find(params[:id])
    @user.update_attribute :user_level, 2
    #redirect_to root_path
  end

  def index
  end
end
