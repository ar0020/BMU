json.array!(@accounts) do |account|
  json.extract! account, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url account_url(account, format: :json)
end
