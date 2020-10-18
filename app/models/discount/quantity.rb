# frozen_string_literal: true

class Discount
  class Quantity < Discount
    store_accessor :configuration, :product_id, :quantity

    validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  end
end
