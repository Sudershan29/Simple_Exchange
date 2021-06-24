json.extract! coin_request, :id, :sender, :receiver, :coin, :price, :user_id, :created_at, :updated_at
json.url coin_request_url(coin_request, format: :json)
