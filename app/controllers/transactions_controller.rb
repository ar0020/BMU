class TransactionsController < ApplicationController

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :account_id, :amount, :transaction_type, :description)
  end
end
