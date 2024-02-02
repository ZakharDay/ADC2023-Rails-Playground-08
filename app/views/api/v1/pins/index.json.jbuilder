json.set! :new_url, api_v1_pins_url

json.set! :pins do
  json.array! @pins, partial: "api/v1/pins/pin", as: :pin
end
