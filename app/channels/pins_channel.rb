class PinsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pins_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
