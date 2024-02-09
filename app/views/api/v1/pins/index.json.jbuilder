json.set! :jti, User.find_by_email('user_1@email.com').jti

json.set! :pins do
  json.array! @pins, partial: "api/v1/pins/pin", as: :pin
end
