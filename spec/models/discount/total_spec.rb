# frozen_string_literal: true

RSpec.describe Discount::Total do
  it { is_expected.to validate_presence_of(:sum_cents) }
  it { is_expected.to validate_numericality_of(:sum_cents).is_greater_than(0).only_integer }

  describe '#filter_items' do
    subject { discount.filter_items(items) }

    let(:discount) { described_class.new(sum_cents: sum.cents) }
    let(:items) { build_list(:checkout_item, 2) }

    context 'when discount sum is lower than items sum' do
      let(:sum) { items.sum(&:price) - MoneyHelper.convert(1) }

      it { is_expected.to eq(items) }
    end

    context 'when discount sum is equal to items sum' do
      let(:sum) { items.sum(&:price) }

      it { is_expected.to eq(items) }
    end

    context 'when discount sum is higher than items sum' do
      let(:sum) { items.sum(&:price) + MoneyHelper.convert(1) }

      it { is_expected.to eq([]) }
    end
  end
end
