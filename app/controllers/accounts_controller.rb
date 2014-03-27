class AccountsController < ApplicationController
  #before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_filter :admin_protect, except: [:show]

  # GET /accounts
  # GET /accounts.json
  
  def index
    if params[:user]
      @account = Account.new(search_params)
      @accounts = Account.users(@user)
    end
    @account = Account.new  
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
  end

  def new
    @user = User.find(params[:id])
    @account = Account.new
    @account.user_id = @user.id
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.current_balance = 0.00

    if @account.account_type == "Checking"
      render create_checking(@account)
    end
    respond_to do |format|
      if true #@account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end


  # DISABLE /accounts/1
  # DISABLE /accounts/1.json
  def disable
    @account.is_active = false
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :account_type, :monthly_account_rate, :is_active)
    end
end
