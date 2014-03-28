class SavingsController < AccountsController
  before_action :set_saving, only: [:show, :edit, :update]


  # GET /savings/1
  # GET /savings/1.json
  def show

  end


  # GET /savings/1/edit
  def edit
  end


  # PATCH/PUT /savings/1
  # PATCH/PUT /savings/1.json
  def update
    respond_to do |format|
      if @saving.update(saving_params)
        format.html { redirect_to @saving, notice: 'Saving was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @saving.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saving
      @saving = Saving.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saving_params
      params.require(:saving).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)
    end
end
