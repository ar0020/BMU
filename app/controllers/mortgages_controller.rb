class MortgagesController < AccountsController
  before_action :set_mortgage, only: [:show, :edit, :update]

  # GET /mortgages/1
  # GET /mortgages/1.json
  def show
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
      params.require(:mortgage).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)
    end
end
