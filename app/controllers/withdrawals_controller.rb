class WithdrawalsController < TransactionsController
  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
    if params[:id]
      @withdrawal.account_id = params[:id]
    end
  end

  # POST /withdrawals
  # POST /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(deposit_params)
    @withdrawal.user_id = current_user.id

    respond_to do |format|
      if @withdrawal.deposit
        format.html { redirect_to transactions_path, notice: 'Deposit was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_withdrawal
      @withdrawal = Withdrawal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def withdrawal_params
      params.require(:withdrawal).permit(:user_id, :account_id, :amount, :transaction_type, :description)
    end
end
