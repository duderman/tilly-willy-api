# frozen_string_literal: true

FactoryBot.define do
  factory :checkout do
    trait :with_items do
      transient do
        items_count { 1 }
      end

      after(:create) do |checkout, evaluator|
        checkout.items = create_list(:checkout_item, evaluator.items_count, checkout: checkout)
      end
    end
  end
end
