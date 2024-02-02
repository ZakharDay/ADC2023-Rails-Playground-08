json.extract! pin, :title, :description, :created_at
# json.pin_image request.base_url + pin.pin_image.url
json.url api_v1_pin_url(pin, format: :json)
