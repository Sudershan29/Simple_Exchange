json.extract! request, :id, :amount, :value, :user_id, :created_at, :updated_at
json.url request_url(request, format: :json)
