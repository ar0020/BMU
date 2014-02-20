class AdminController < ApplicationController
  before_filter :authorize_member!
  
  def index
    
  end  
  
  def create_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    #redirect_to root_path
  end
  
  def delete_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, false  
    redirect_to root_path  
  end
  
protected

  def authorize_member!
    unless admin?
      render text: '403: Forbidden', status: :forbidden
      false
    end
  end
end
