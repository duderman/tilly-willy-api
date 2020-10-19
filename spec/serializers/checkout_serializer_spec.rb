# frozen_string_literal: true

RSpec.describe CheckoutSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(checkout) }
  let(:checkout) { build(:checkout, :with_items, items_count: 2, id: SecureRandom.uuid) }
  let(:discount) { build(:total_discount) }

  before { checkout.items.each { _1.discount = discount } }

  its([:id]) { is_expected.to eq(checkout.id) }
  its([:items]) { is_expected.to eq(checkout.items.map { ItemSerializer.new(_1).serializable_hash }) }
  its([:discounts]) { is_expected.to eq([DiscountSerializer.new(discount).serializable_hash]) }
end
