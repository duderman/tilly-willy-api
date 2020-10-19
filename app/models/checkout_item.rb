class CheckoutItem < ApplicationRecord
  belongs_to :checkout
  belongs_to :product
  belongs_to :discount

  monetize :price_cents, numericality: { greater_than: 0 }
  monetize :discount_price_cents, allow_nil: true, numericality: { greater_than: 0 }
end
