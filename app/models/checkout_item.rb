# frozen_string_literal: true

class CheckoutItem < ApplicationRecord
  belongs_to :checkout
  belongs_to :product
  belongs_to :discount, optional: true

  monetize :price_cents, numericality: { greater_than: 0 }
end
