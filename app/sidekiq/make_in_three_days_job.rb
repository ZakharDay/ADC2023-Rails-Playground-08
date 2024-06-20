class MakeInThreeDaysJob
  include Sidekiq::Job

  def perform(pin_id, user_id)
    pin = Pin.find(pin_id)
    pin.comments.create!(body: 'Первый!', user_id: user_id)
  end
end
