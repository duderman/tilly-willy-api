class ItemsController < ApplicationController
  before_action :set_checkout

  def destroy
    item = @checkout.items.find(params[:id])
    RemoveItemFromCheckout.call(item, @checkout)

    render json: @checkout
  end

  private

  def checkout_id
    params[:checkout_id]
  end
end
