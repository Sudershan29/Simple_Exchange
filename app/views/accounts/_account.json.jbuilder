json.extract! account, :id, :name, :ph_number, :currency, :coin, :created_at, :updated_at
json.url account_url(account, format: :json)
