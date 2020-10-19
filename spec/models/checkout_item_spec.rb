RSpec.describe CheckoutItem do
  it { is_expected.to belong_to(:checkout).required }
  it { is_expected.to belong_to(:product).required }
  it { is_expected.to belong_to(:discount).required }

  it { is_expected.to monetize(:price_cents) }
  it { is_expected.to monetize(:discount_price_cents).allow_nil }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:discount_price).is_greater_than(0).allow_nil }
end
