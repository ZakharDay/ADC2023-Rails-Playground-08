class Api::V1::PinsController < Api::V1::ApplicationController
  def index
    @pins = Pin.all
    # render json: @pins.map { |pin| pin.api_as_json }
  end

  def show
    @pin = Pin.find(params[:id])
  end
end
