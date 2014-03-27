class UserController < ApplicationController
  before_filter :admin_teller_protect, :only=>[:index,:search]
  
  def index
    if params[:user]
      @user = User.new(user_params)
      @users = User.users(@user)
    end
    @user = User.new  
    respond_to do |format|
     format.html #responds with default html file
     format.js #this will be the javascript file we respond with
    end
  end
  
  def search
    @users = User.where("users.username LIKE ?", params[:user][:username])
    respond_to do |format|
     format.html #responds with default html file
     format.js #this will be the javascript file we respond with
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :id)
  end
end
