class TransfersController < TransactionsController
  before_filter :teller_customer_protect

  # GET /transfers/new
  def new
    if teller? && params[:id]
      @account = Account.find(params[:id])
      @user = User.find(@account.user_id)
    elsif customer?
      @user = current_user
    end
    if @user
      @accounts = Account.where("accounts.user_id = ?", @user.id)
    end
    @transfer = Transfer.new
    if params[:id]
      @transfer.from_account_id = params[:id]
    end
  end

  # POST /transfers
  # POST /transfers.json
  def create
    Transfer.transaction do
      @to_transfer = Transfer.new(transfer_params)
      @from_transfer = Transfer.new(transfer_params)
    end

    @to_transfer.user_id = current_user.id
    @from_transfer.user_id = current_user.id

    respond_to do |format|
      if Transfer.transfer(@to_transfer, @from_transfer)
        format.html { redirect_to account_path(@from_transfer.account_id), notice: 'Transfer was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @from_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:from_account_id, :to_account_id, :account_id, :amount_string)
    end
end
