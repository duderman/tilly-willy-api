# frozen_string_literal: true

RSpec.describe Discount::Quantity do
  let(:product) { create(:product) }

  it { is_expected.to validate_presence_of(:product_id) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).only_integer }
  it { is_expected.to allow_value(product.id).for(:product_id) }
  it { is_expected.not_to allow_value(nil).for(:product_id).with_message('has an ID of a non-existing product') }

  describe '#filter_items' do
    subject { discount.filter_items(items) }

    let(:discount) { described_class.new(product_id: product.id, quantity: quantity) }
    let(:product) { build(:product, id: SecureRandom.uuid) }
    let(:items) { matching_items + build_list(:checkout_item, 2) }
    let(:matching_items) { build_list(:checkout_item, 2, product_id: product.id) }

    context 'when quantity is lower than matching items count' do
      let(:quantity) { 1 }

      it { is_expected.to eq(matching_items) }
    end

    context 'when quantity is equal to matching items count' do
      let(:quantity) { 2 }

      it { is_expected.to eq(matching_items) }
    end

    context 'when quantity is higher than matching items count' do
      let(:quantity) { 3 }

      it { is_expected.to eq([]) }
    end
  end

  describe '#rules' do
    subject { discount.rules }

    let(:discount) { build(:quantity_discount, product_id: SecureRandom.uuid, quantity: 2) }

    it { is_expected.to eq(product_id: discount.product_id, quantity: 2) }
  end
end
