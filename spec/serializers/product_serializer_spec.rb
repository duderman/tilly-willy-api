# frozen_string_literal: true

RSpec.describe ProductSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(product) }
  let(:product) { build(:product, code: 1, name: 'Product', price: 9.99) }

  its([:code]) { is_expected.to eq(1) }
  its([:name]) { is_expected.to eq('Product') }
  its([:price]) { is_expected.to eq(9.99) }
  its([:currency]) { is_expected.to eq('GBP') }
end
