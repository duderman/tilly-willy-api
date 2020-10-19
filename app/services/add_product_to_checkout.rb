# frozen_string_literal: true

class AddProductToCheckout < ApplicationService
  attr_reader :product, :checkout

  def initialize(product, checkout)
    @product = product
    @checkout = checkout
  end

  def call
    checkout.items << item
    checkout
  end

  private

  def item
    @item ||= CheckoutItem.new(checkout: checkout, product: product, price: product.price)
  end
end
