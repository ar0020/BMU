class MarketsController < AccountsController

  def new
    @user = User.find(params[:id])
    @market = Market.new
    @market.user_id = @user.id
  end

  def create
    @market = Market.new(market_params)
    @market.account_type = "Market"

    respond_to do |format|
      if @market.save
        format.html { redirect_to root_path, notice: 'Market account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'market', action: 'new' }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market
      @market = Market.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_params
      params.require(:market).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)
    end
end
