json.set! :pins do
  json.array! @pins, partial: "api/v1/pins/pin", as: :pin
end
