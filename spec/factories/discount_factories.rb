# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    percentage { 10 }

    trait :price do
      percentage { nil }
      price_cents { 100 }
    end
  end

  factory :quantity_discount, class: 'Discount::Quantity', parent: :discount do
    product_id { create(:product).id }
    quantity { 1 }
  end

  factory :total_discount, class: 'Discount::Total', parent: :discount do
    sum_cents { 500 }
  end
end
