class TestController < ApplicationController
  before_filter :admin_protect
  
  def index
  end
  
  def credit_rate
    ActiveRecord::Base.connection.execute(%{
      UPDATE accounts
        SET current_balance = current_balance + (current_balance * monthly_account_rate)
        WHERE account_type = 'Credit'     
    })
    redirect_to admin_panel_path
  end
  
  def market_rate
    ActiveRecord::Base.connection.execute(%{
      UPDATE accounts
        SET current_balance = current_balance + (current_balance * monthly_account_rate)
        WHERE account_type = 'Market'     
    })
    redirect_to admin_panel_path
  end
  
  def saving_rate
    ActiveRecord::Base.connection.execute(%{
      UPDATE accounts
        SET current_balance = current_balance + (current_balance * monthly_account_rate)
        WHERE account_type = 'Saving'     
    })
    redirect_to admin_panel_path
  end
  
  def mortgages_behind
    @accounts = Account.find_by_sql [%{
      SELECT accounts.id, yearly_account_rate, amount_paid, current_balance, user_id, yearly_account_rate - amount_paid AS amount_due
      FROM (
        SELECT accounts.id, created_at, now(), current_balance, user_id,
        (monthly_account_rate * ((extract( year FROM now()) - extract( year FROM created_at )) *12) + extract(MONTH FROM now()) - extract(MONTH FROM created_at)) as yearly_account_rate
        
        FROM accounts
        WHERE (accounts.account_type LIKE ?) AND
              (current_balance != 0)
      ) accounts
      LEFT OUTER JOIN (
        SELECT sum(amount) as amount_paid, account_id
        FROM transactions
        GROUP BY account_id
      ) transactions ON transactions.account_id = accounts.id
      LEFT OUTER JOIN users ON accounts.user_id = users.id
      WHERE (amount_paid < yearly_account_rate)
      ORDER BY amount_due DESC;

    }, 'Mortgage%']
  end
  
end
