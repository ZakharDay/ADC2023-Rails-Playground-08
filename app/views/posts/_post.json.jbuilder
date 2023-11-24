json.extract! post, :id, :type, :title, :body, :url, :created_at, :updated_at
json.url post_url(post, format: :json)
