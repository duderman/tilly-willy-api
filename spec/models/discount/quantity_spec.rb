# frozen_string_literal: true

RSpec.describe Discount::Quantity do
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).only_integer }
end
