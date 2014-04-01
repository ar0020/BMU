class DepositsController < TransactionsController
  before_filter :teller_protect

  # GET /deposits/new
  def new
    @deposit = Deposit.new
    if params[:id]
      @deposit.account_id = params[:id]
    end
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
    @deposit.user_id = current_user.id
    @account = Account.find(@deposit.account_id)

    respond_to do |format|
      if @deposit.deposit
        format.html { redirect_to account_path(@deposit.account_id), notice: 'Deposit was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposit_params
    params.require(:deposit).permit(:account_id, :amount)
  end
end
