# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def set_checkout
    @checkout = Checkout.preload(items: %i[product discount]).find(checkout_id)
  end
end
