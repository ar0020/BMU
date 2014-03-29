json.array!(@bills) do |bill|
  json.extract! bill, :id, :user_id, :account_id, :is_recurring, :payee_name, :payee_street, :payee_city, :payee_state, :payee_zip, :payee_account_id
  json.url bill_url(bill, format: :json)
end
