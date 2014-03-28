class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transation).permit(:user_id, :account_id, :amount, :transaction_type, :description)
    end
end
