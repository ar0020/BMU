json.array!(@markets) do |market|
  json.extract! market, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url market_url(market, format: :json)
end
