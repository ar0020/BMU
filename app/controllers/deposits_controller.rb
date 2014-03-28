class DepositsController < TransactionsController

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
    @account = Account.find(@deposit.account_id)

    @deposit.user_id = current_user.id
    @deposit.transaction_type = 'Deposit'

    @account.current_balance += @deposit.amount.abs

    respond_to do |format|
      if @deposit.validate_transaction_on_account?
        Deposit.transaction do
          @deposit.save!
          @account.save!
        end
        format.html { redirect_to transactions_path, notice: 'Deposit was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'transactions' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  private



    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:user_id, :account_id, :amount, :transaction_type, :description)
    end
end
