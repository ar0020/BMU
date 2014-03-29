class AdministratorController < ApplicationController
  before_filter :admin_protect
  
  def index
  end
end
