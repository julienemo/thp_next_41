json.extract! user, :id, :firt_name, :last_name, :username, :created_at, :updated_at
json.url user_url(user, format: :json)
