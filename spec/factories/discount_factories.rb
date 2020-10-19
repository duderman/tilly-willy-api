# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    percentage { 10 }
  end

  factory :quantity_discount, class: 'Discount::Quantity', parent: :discount do
    product_id { create(:product).id }
    quantity { 1 }
  end
end
