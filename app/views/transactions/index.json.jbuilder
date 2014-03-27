json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :user_id, :account_id, :amount, :transaction_type, :description
  json.url transaction_url(transaction, format: :json)
end
