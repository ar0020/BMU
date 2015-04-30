class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :enable, :disable]
  prawnto :prawn => {:top_margin => 75}

  # GET /accounts
  # GET /accounts.json
  def index
    if params[:account]
      @account = Account.new(search_params)
      @accounts = Account.accounts(@account)
    else
      @account = Account.new
    end
    respond_to do |format|
      format.html #responds with default html file
      format.js #this will be the javascript file we respond with
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
    @transactions = Transaction.transactions(@account.id)
    @user = User.find(@account.user_id)
    @bills = Bill.where(account_id: @account.id)
  end

  # DISABLE /accounts/1
  # DISABLE /accounts/1.json
  def disable
    @account.update_attribute :is_active, false
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def enable
    @account.update_attribute :is_active, true
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def destroy
    @transaction = Transaction.where(:account_id=>@account.id).first
    @user = User.find(@account.user_id)
    if @transaction.nil?
      @account.delete
      flash[:notice] = "Account has been deleted."
    else
      flash[:notice] = "No longer able to delete account. Try disabling it."
    end
    redirect_to :controller=>:customer, :action=>:index, :id=>@user.id
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_id, :monthly_account_rate, :is_active)
  end

  def search_params
    params.require(:account).permit(:id, :username, :account_type, :user_id, :monthly_account_rate, :is_active)
  end
end
