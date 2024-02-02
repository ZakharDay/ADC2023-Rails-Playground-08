class CartsController < ApplicationController

  def add
    @product = Product.find(params[:id])
    cart = @guest.carts.last
    cart.products << @product

    respond_to do |format|
      format.turbo_stream
    end
  end

end
