json.array!(@credits) do |credit|
  json.extract! credit, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url credit_url(credit, format: :json)
end
