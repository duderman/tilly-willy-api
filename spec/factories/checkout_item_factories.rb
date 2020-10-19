# frozen_string_literal: true

FactoryBot.define do
  factory :checkout_item do
    checkout
    product
    price_cents { (1..1000).to_a.sample }
  end
end
