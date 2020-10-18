# frozen_string_literal: true

RSpec.describe Product do
  subject { build(:product) }

  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_numericality_of(:code).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
end
