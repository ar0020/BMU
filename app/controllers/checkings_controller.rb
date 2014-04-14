class CheckingsController < AccountsController
  before_action :set_checking, only: [:edit, :update]
  before_filter :admin_protect

  def new
    @user = User.find(params[:id])
    @checking = Checking.new
    @checking.user_id = @user.id
  end

  def create
    @checking = Checking.new(checking_params)

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
      params.require(:checking).permit(:user_id, :balance_string, :is_active)
    end
end
