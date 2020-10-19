RSpec.describe Checkout do
  it { is_expected.to have_many(:items).class_name('CheckoutItem') }
end
