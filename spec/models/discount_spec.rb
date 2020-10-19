# frozen_string_literal: true

RSpec.describe Discount do
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:configuration) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0).allow_nil }
  it { is_expected.to monetize(:price_cents).allow_nil }

  it do
    is_expected.to validate_numericality_of(:percentage).is_greater_than(0)
                                                        .is_less_than_or_equal_to(100)
                                                        .only_integer.allow_nil
  end

  it 'validates presence of discount amount' do
    discount = described_class.new
    discount.validate
    expect(discount.errors[:base]).to include('should have either percentage or price configured')
  end

  it "doesn't allow both percentage and price to be configured" do
    discount = described_class.new(percentage: 99, price_cents: 2.22)
    discount.validate
    expect(discount.errors[:base]).to include('should have either percentage or price configured')
  end

  describe '#coefficent' do
    subject { discount.coefficent }

    let(:discount) { described_class.new(percentage: percentage) }
    let(:percentage) { 10 }

    it { is_expected.to eq(0.1) }

    context 'when percentage is nil' do
      let(:percentage) { nil }

      it { is_expected.to eq(0) }
    end
  end

  describe '#calculate_price' do
    subject { discount.calculate_price(price) }

    let(:price) { MoneyHelper.convert(100) }

    context 'when discount is based on percentage' do
      let(:discount) { described_class.new(percentage: 10) }

      it { is_expected.to eq(MoneyHelper.convert(90)) }
    end

    context 'when discount is price based' do
      let(:discount) { described_class.new(price: discount_price) }
      let(:discount_price) { MoneyHelper.convert(9.99) }

      it { is_expected.to eql(discount_price) }
    end
  end
end
