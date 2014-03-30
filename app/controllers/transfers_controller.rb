class TransfersController < TransactionsController
  before_filter :teller_customer_protect

  # GET /transfers/new
  def new
    if teller? && params[:id]
      @user = User.find(params[:id])
    elsif customer?
      @user = current_user
    end
    if @user
      @accounts = Account.where("accounts.user_id = ?", @user.id)
    end
    @transfer = Transfer.new
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.user_id = current_user.id

    respond_to do |format|
      if @transfer.transfer
        format.html { redirect_to transactions_path, notice: 'Transfer was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def transfer_params
    params.require(:transfer).permit(:from_account_id, :to_account_id, :account_id, :amount)
  end
end
