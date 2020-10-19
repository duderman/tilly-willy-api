# frozen_string_literal: true

class RemoveItemFromCheckout < CheckoutModifier
  attr_reader :item

  def initialize(item, checkout)
    super(checkout)
    @item = item
  end

  def modify_checkout
    return unless checkout.items.include?(item)

    checkout.items.destroy(item)
  end
end
