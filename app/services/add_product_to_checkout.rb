# frozen_string_literal: true

class AddProductToCheckout < CheckoutModifier
  attr_reader :product

  def initialize(product, checkout)
    super(checkout)
    @product = product
  end

  def modify_checkout
    checkout.items << item
  end

  private

  def item
    @item ||= CheckoutItem.new(checkout: checkout, product: product, price: product.price)
  end
end
