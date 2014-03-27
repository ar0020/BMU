json.array!(@mortgages) do |mortgage|
  json.extract! mortgage, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url mortgage_url(mortgage, format: :json)
end
