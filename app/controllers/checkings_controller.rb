class CheckingsController < AccountsController
  before_filter :admin_protect  
  
  def new
    @user = User.find(params[:id])
    @checking = Checking.new
    @checking.user_id = @user.id
  end

  def create
    #@account = Account.new
    #@checking = @account.checking.new(checking_params)
    @checking = Checking.new(checking_params)
    #@checking.current_balance = 0.00
    #@checking.account_type = "Checking"
    #@user = User.find(@checking.user_id)
    #@checking = @user.id

    respond_to do |format|
      if @checking.save
        format.html { redirect_to @checking, notice: 'Checking account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @checking }
      else
        format.html { render controller: 'checking', action: 'new' }
        format.json { render json: @checking.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /checkings/1
  # GET /checkings/1.json
  def show
    @checking ||= Checking.find(params[:id])
  end

  def create
    @checking = Checking.new(checking_params)
    @checking.account_type = "Checking"

    respond_to do |format|
      if @checking.save
        format.html { redirect_to account_path(@checking), notice: 'Checking account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render controller: 'checking', action: 'new' }
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
      params.require(:checking).permit(:user_id, :current_balance, :is_active)
    end
end
