class AdministratorController < ApplicationController
  before_filter :admin_protect
  
  def create
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    #redirect_to root_path
  end
  
  def index
  end
  
protected

  def authorize_member!
    unless admin?
      render text: '403: Forbidden', status: :forbidden
      false
    end
  end
end
