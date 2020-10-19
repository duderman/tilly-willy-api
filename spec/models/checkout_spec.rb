# frozen_string_literal: true

RSpec.describe Checkout do
  it { is_expected.to have_many(:items).class_name('CheckoutItem').dependent(:delete_all) }
end
