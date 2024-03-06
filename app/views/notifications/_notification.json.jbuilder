json.extract! notification, :id, :user_id, :body, :read, :created_at, :updated_at
json.url notification_url(notification, format: :json)
