# frozen_string_literal: true

class ApplyDiscount < ApplicationService
  attr_reader :items, :discount

  def initialize(items, discount)
    @items = items
    @discount = discount
  end

  def call
    applicable_items.each(&method(:apply))
    items
  end

  private

  def applicable_items
    discount.filter_items(items)
  end

  def apply(item)
    item.discount = discount
    item.price = discount.calculate_price(item.price)
  end
end
