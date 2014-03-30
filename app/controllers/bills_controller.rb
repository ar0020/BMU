class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy, :disable, :enable]

  # GET /bills
  # GET /bills.json
  def index
    if params[:user]
      @bill = Bill.new(search_params)
      @bills = Bill.users(@user)
    end
    @bill = Bill.new
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
    if params[:id] && params[:user_id]
      @bill.account_id = params[:id]
      @bill.user_id = params[:user_id]
    end
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

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
    respond_to do |format|
      format.html { redirect_to customer_by_id_path(@bill.user_id) }
      format.json { head :no_content }
    end
  end

  # ENABLE /accounts/1
  # ENABLE /accounts/1.json
  def enable
    @bill.update_attribute :is_recurring, true
    respond_to do |format|
      format.html { redirect_to customer_by_id_path(@bill.user_id) }
      format.json { head :no_content }
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url }
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
      params.require(:bill).permit(:user_id, :account_id, :is_recurring, :payee_name, :payee_street, :payee_city, :payee_state, :payee_zip, :payee_account_id, :amount, :pay_date)
    end
end
