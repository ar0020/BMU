class WithdrawalsController < TransactionsController
  before_filter :teller_protect

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
    @withdrawal = Withdrawal.new(withdrawal_params)
    @withdrawal.user_id = current_user.id

    respond_to do |format|
      if @withdrawal.withdrawal
        format.html { redirect_to account_path(@deposit.account_id), notice: 'Withdrawal was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def withdrawal_params
    params.require(:withdrawal).permit(:account_id, :amount)
  end
end
