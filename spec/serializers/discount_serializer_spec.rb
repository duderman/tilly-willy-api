# frozen_string_literal: true

RSpec.describe DiscountSerializer do
  subject { serializer.serializable_hash }

  let(:serializer) { described_class.new(discount) }
  let(:discount) { build(:total_discount) }

  its([:price]) { is_expected.to be_nil }
  its([:percentage]) { is_expected.to eq(10) }
  its(%i[rules sum]) { is_expected.to eq(MoneyHelper.convert(5.00)) }
end
