class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user]
      @user = User.new(search_params)
      if teller?
        @user.user_level = 3
      end
      @users = @user.users
    else
      @user = User.new
    end
    respond_to do |format|
     format.html #responds with default html file
     format.js #this will be the javascript file we respond with
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      
    else
      render 'new'
    end
  end

  private
  def set_user
    @user = User.find(params[:id]) if params[:id]
  end

  def search_params
    params.require(:user).permit(:username, :email, :id, :user_level)
  end

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :password_digest,
      :user_level
      )
  end
end
