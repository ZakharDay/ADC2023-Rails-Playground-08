class WaitAndMakeJob < ApplicationJob# < Resque::Job
  queue_as :default

  def self.queue
    :default
  end

  def self.perform(pin, user)
    Resque.logger.info '================================'
    pin.comments.create!(body: 'Первый!', user_id: user.id)
  end
end
