json.extract! transaction, :id, :sender, :receiver, :amount, :value, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
