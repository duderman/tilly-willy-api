# frozen_string_literal: true

RSpec.describe DiscountSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(discount) }
  let(:discount) { build(:total_discount) }

  it { is_expected.not_to have_key(:price) }
  it { is_expected.not_to have_key(:currency) }
  its([:percentage]) { is_expected.to eq(10) }
  its(%i[rules sum]) { is_expected.to eq(MoneyHelper.convert(5.00)) }

  context 'when discount is a price discount' do
    let(:discount) { build(:total_discount, :price) }

    it { is_expected.not_to have_key(:percentage) }
    its([:price]) { is_expected.to eq(discount.price.to_f) }
    its([:currency]) { is_expected.to eq(discount.price.currency.to_s) }
  end

  context 'when discount is a quantity discount' do
    let(:discount) { build(:quantity_discount, product_id: SecureRandom.uuid) }

    its([:rules]) { is_expected.to eq(product_id: discount.product_id, quantity: 1) }
  end
end
