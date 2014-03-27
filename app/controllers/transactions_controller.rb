class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  # GET /transactions
  # GET /transactions.json
  def index
    if current_user.teller || current_user.admin
      @transactions = Transaction.all
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
