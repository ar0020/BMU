class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy, :disable, :enable]

  # GET /bills
  # GET /bills.json
  def index
    if params[:user]
      @bill = Bill.new(search_params)
      @bills = Bill.users(@user)
      @account = Account.find(@bill.user_id)
    end
    @bill = Bill.new
    @account = Account.new
    respond_to do |format|
      format.html #responds with default html file
      format.js #this will be the javascript file we respond with
    end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bills = Bill.find(params[:id])
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @bill.user_id = current_user.id
    @user = current_user
    @accounts = Account.where(user_id: current_user.id)
  end

  # GET /bills/1/edit
  def edit
    @user = current_user
    @accounts = Account.where(user_id: current_user.id)
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)
    @bill.user_id = current_user.id
    @user = current_user
    @accounts = Account.where(user_id: current_user.id)
    @bill.amount = @bill.amount_string.to_f

    respond_to do |format|
      if @bill.save
        format.html { redirect_to account_path(@bill.account_id), notice: 'Bill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end


  # DISABLE /accounts/1
  # DISABLE /accounts/1.json
  def disable
    @bill.update_attribute :is_recurring, false
    account = Account.find(@bill.account_id)
    user = User.find(account.user_id)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  # ENABLE /accounts/1
  # ENABLE /accounts/1.json
  def enable
    @bill.update_attribute :is_recurring, true
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to account_path(@bill.account_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:user_id, :amount_string, :account_id, :is_recurring, :payee_name, :payee_street, :payee_city, :payee_state, :payee_zip, :payee_account_id, :pay_date)
    end
end
