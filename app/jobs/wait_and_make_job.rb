class WaitAndMakeJob < ApplicationJob
  queue_as :default

  def perform(pin, user)
    pin.comments.create!(body: 'Первый!', user_id: user.id)
  end
end
