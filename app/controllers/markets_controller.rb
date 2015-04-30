class MarketsController < AccountsController
  before_action :set_market, only: [:edit, :update]

  def new
    @user = User.find(params[:id])
    @market = Market.new
    @market.user_id = @user.id
  end

  def create
    @market = Market.new(market_params)

    respond_to do |format|
      if @market.save
        format.html { redirect_to account_path(@market.id), notice: 'Market account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'market', action: 'new' }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /markets/1/edit
  def edit
  end


  # PATCH/PUT /markets/1
  # PATCH/PUT /markets/1.json
  def update
    respond_to do |format|
      if @market.update(market_params)
        format.html { redirect_to @market, notice: 'Market was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      params.require(:market).permit(:user_id, :balance_string, :account_type, :monthly_account_rate, :is_active)
    end
end
