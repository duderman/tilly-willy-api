# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:code)
    name { FFaker::Product.product_name }
    price_cents { (1..10_000).to_a.sample }
  end
end
