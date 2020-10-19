# frozen_string_literal: true

RSpec.describe CheckoutItem do
  it { is_expected.to belong_to(:checkout).required }
  it { is_expected.to belong_to(:product).required }
  it { is_expected.to belong_to(:discount).optional }

  it { is_expected.to monetize(:price_cents) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
end
