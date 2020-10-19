# frozen_string_literal: true

RSpec.describe CheckoutSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(checkout) }
  let(:checkout) { build(:checkout, id: SecureRandom.uuid) }

  its([:id]) { is_expected.to eq(checkout.id) }
end
