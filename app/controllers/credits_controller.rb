class CreditsController < AccountsController
  before_action :set_credit, only: [:edit, :update]
  before_filter :admin_protect


  def new
    @user = User.find(params[:id])
    @credit = Credit.new
    @credit.user_id = @user.id
  end

  def create
    @credit = Credit.new(credit_params)

    respond_to do |format|
      if @credit.save
        format.html { redirect_to account_path(@credit.id), notice: 'Credit account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'credit', action: 'new' }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /credits/1/edit
  def edit
  end

  # PATCH/PUT /credits/1
  # PATCH/PUT /credits/1.json
  def update
    respond_to do |format|
      if @credit.update(credit_params)
        format.html { redirect_to @credit, notice: 'Credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:credit).permit(:user_id, :balance_string, :account_type, :monthly_account_rate, :is_active)
    end
end
