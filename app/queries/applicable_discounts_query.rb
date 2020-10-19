# frozen_string_literal: true

class ApplicableDiscountsQuery
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    quantity_discounts.or(total_discounts)
  end

  private

  def quantity_discounts
    Discount.where(type: Discount::Quantity.to_s)
            .where("configuration ->> 'product_id' IN (:product_ids)", product_ids: product_ids)
  end

  def product_ids
    items.map(&:product_id).uniq.compact
  end

  def total_discounts
    Discount.where(type: Discount::Total.to_s)
  end
end
