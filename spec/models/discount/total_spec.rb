# frozen_string_literal: true

RSpec.describe Discount::Total do
  it { is_expected.to validate_presence_of(:sum) }
  it { is_expected.to validate_numericality_of(:sum).is_greater_than(0) }
end
