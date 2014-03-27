json.array!(@checkings) do |checking|
  json.extract! checking, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url checking_url(checking, format: :json)
end
