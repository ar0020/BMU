json.array!(@savings) do |saving|
  json.extract! saving, :id, :user_id, :current_balance, :account_type, :monthly_account_rate, :is_active
  json.url saving_url(saving, format: :json)
end
