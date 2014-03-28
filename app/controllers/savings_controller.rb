class SavingsController < AccountsController

  def new
    @user = User.find(params[:id])
    @saving = Saving.new
    @saving.user_id = @user.id
  end

  def create
    @saving = Saving.new(saving_params)
    @saving.account_type = "Saving"

    respond_to do |format|
      if @saving.save
        format.html { redirect_to root_path, notice: 'Saving account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'saving', action: 'new' }
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
