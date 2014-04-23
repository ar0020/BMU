class UserController < ApplicationController
  before_filter :admin_teller_protect

  def index
    if params[:user]
      @user = User.new(search_params)
      if teller?
        @user.user_level = 3
      end
      @users = User.users(@user)
    else
      @user = User.new
    end
    respond_to do |format|
     format.html #responds with default html file
     format.js #this will be the javascript file we respond with
    end
  end

  private

  def search_params
    params.require(:user).permit(:username, :email, :id, :user_level)
  end
end
