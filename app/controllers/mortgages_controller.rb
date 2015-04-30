class MortgagesController < AccountsController
  before_action :set_mortgage, only: [:edit, :update]

  def new
    @user = User.find(params[:id])
    @mortgage = Mortgage.new
    @mortgage.user_id = @user.id
  end

  def create
    @mortgage = Mortgage.new(mortgage_params)
    #@mortgage.account_type = "Mortgage"

    respond_to do |format|
      if @mortgage.save
        format.html { redirect_to account_path(@mortgage.id), notice: 'Mortgage account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'mortgage', action: 'new' }
        format.json { render json: @mortgage.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /mortgages/1/edit
  def edit
  end

  # PATCH/PUT /mortgages/1
  # PATCH/PUT /mortgages/1.json
  def update
    respond_to do |format|
      if @mortgage.update(mortgage_params)
        format.html { redirect_to @mortgage, notice: 'Mortgage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mortgage.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mortgage
      @mortgage = Mortgage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mortgage_params
      params.require(:mortgage).permit(:user_id, :balance_string, :account_type, :monthly_account_rate, :is_active)
    end
end
