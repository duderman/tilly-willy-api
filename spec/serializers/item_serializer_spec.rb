# frozen_string_literal: true

RSpec.describe ItemSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(item) }
  let(:item) { build(:checkout_item, id: SecureRandom.uuid, product_id: SecureRandom.uuid) }

  its([:id]) { is_expected.to eq(item.id) }
  its([:price]) { is_expected.to eq(item.price) }
  its([:product_id]) { is_expected.to eq(item.product_id) }
end
