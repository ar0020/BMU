pdf.text "#{@user.username}"
pdf.text "#{@account.account_type} Account Statement", :size => 15, :style => :bold
pdf.move_down(10)
pdf.text "Account Number: ****#{@account.display_account_ending}"
pdf.text "Account Type: #{@account.account_type}"
pdf.text "Current Balance: #{number_to_currency(@account.current_balance)}"
pdf.text "Monthly Account Rate: #{number_to_percentage(@account.monthly_account_rate)}"
pdf.move_down(10)
if !@transactions.blank?
    transactions = @transactions.map do |transaction|
      [
        transaction.transaction_type,
        number_to_currency(transaction.amount),
        transaction.created_at.strftime("%d %b. %Y : %I:%M%p")
      ]
    end

    pdf.table(transactions, :row_colors => ["FFFFFF","DDDDDD"])
else
pdf.text "NO HISTORY"
end
