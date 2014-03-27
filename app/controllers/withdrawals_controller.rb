class WithdrawalsController < TransactionsController
  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
  end

  def show
  end

  # POST /withdrawals
  # POST /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(withdrawal_params)
    @account = Account.find(@withdrawal.account_id)

    @withdrawal.user_id = current_user.id
    @withdrawal.transaction_type = 'Withdrawal'

    @account.current_balance -= @withdrawal.amount.abs

    respond_to do |format|
      if @account.is_active?
        Withdrawal.transaction do
          @withdrawal.save!
          @account.save!
        end
        format.html { redirect_to transactions_path, notice: 'Withdrawal was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'transactions' }
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
