class CheckingsController < AccountsController
  before_action :set_checking, only: [:show, :edit, :update, :destroy]


  def create
    @account = Account.new(account_params)
    @account.current_balance = 0.00

    if @account.account_type == "Checking"
      render create_checking(@account)
    end
    respond_to do |format|
      if true #@account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'account' action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /checkings/1
  # GET /checkings/1.json
  def show
  end


  # GET /checkings/1/edit
  def edit
  end

  # PATCH/PUT /checkings/1
  # PATCH/PUT /checkings/1.json
  def update
    respond_to do |format|
      if @checking.update(checking_params)
        format.html { redirect_to @checking, notice: 'Checking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @checking.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checking
      @checking = Checking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checking_params
      params.require(:checking).permit(:user_id, :current_balance, :account_type, :monthly_account_rate, :is_active)
    end
end
