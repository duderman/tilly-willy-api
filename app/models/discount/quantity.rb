# frozen_string_literal: true

class Discount
  class Quantity < Discount
    store_accessor :configuration, :product_id, :quantity

    validates :product_id, presence: true
    validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :product_exists

    def filter_items(items)
      matching_items = items.select { _1.product_id == product_id }
      return [] if quantity > matching_items.count

      matching_items
    end

    private

    def product_exists
      return if Product.exists?(id: product_id)

      errors.add(:product_id, 'has an ID of a non-existing product')
    end
  end
end
