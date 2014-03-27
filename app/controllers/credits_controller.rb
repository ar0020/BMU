class CreditsController < AccountsController
  before_action :set_credit, only: [:show, :edit, :update]


  # GET /credits/1
  # GET /credits/1.json
  def show
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
      params.require(:credit).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)
    end
end
