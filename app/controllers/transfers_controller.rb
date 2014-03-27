class TransfersController < TransactionsController

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @to_transfer = Transfer.new(transfer_params)
    @from_transfer = Transfer.new(transfer_params)

    @to_transfer.account_id = @to_transfer.to_account_id
    @to_transfer.user_id = current_user.id
    @to_transfer.transaction_type = 'Transfer'

    @from_transfer.account_id = @from_transfer.from_account_id
    @from_transfer.user_id = current_user.id
    @from_transfer.transaction_type = 'Transfer'

    @to_account = Account.find(@to_transfer.to_account_id)
    @from_account = Account.find(@from_transfer.from_account_id)

    @to_account.current_balance += @to_transfer.amount.abs
    @from_account.current_balance -= @from_transfer.amount.abs


    respond_to do |format|
      if ((@to_account.user_id == @from_account.user_id) &&
          (@to_account.is_active && @from_account.is_active))
        Withdrawal.transaction do
          @to_account.save!
          @from_account.save!

          @to_transfer.save!
          @from_transfer.save!
        end
        format.html { redirect_to transactions_path, notice: 'Transfer was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'transactions' }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:user_id, :amount, :to_account_id, :from_account_id)
    end
end
