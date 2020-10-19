# frozen_string_literal: true

class RecalculateDiscounts < ApplicationService
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def call
    reset_prices
    reset_discounts
    apply_regular_discounts
    apply_total_discounts
    save_items
  end

  private

  def reset_prices
    items.each { _1.price = _1.product.price }
  end

  def reset_discounts
    items.each { _1.discount = nil }
  end

  def apply_regular_discounts
    discounts[1].each(&method(:apply_discount))
  end

  def apply_total_discounts
    discounts[0].each(&method(:apply_discount))
  end

  def apply_discount(discount)
    ApplyDiscount.call(items, discount)
  end

  def discounts
    @discounts ||= ApplicableDiscountsQuery.new(items).all.partition { _1.is_a?(Discount::Total) }
  end

  def save_items
    items.each(&:save!)
  end
end
