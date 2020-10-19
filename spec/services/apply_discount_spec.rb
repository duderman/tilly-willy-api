# frozen_string_literal: true

RSpec.describe ApplyDiscount do
  subject(:call) { described_class.call(items, discount) }

  let(:items) { [applicable_item, build(:checkout_item)] }
  let(:applicable_item) { build(:checkout_item, product: product, price: 1.00) }
  let(:product) { build(:product, id: SecureRandom.uuid) }
  let(:discount) { build(:quantity_discount, product_id: product.id) }

  before { call }

  it { is_expected.to eq(items) }

  it 'applies discount to applicable items' do
    expect(applicable_item.price).to eq(MoneyHelper.convert(90))
  end

  it "doesn't save items" do
    expect(applicable_item).not_to be_persisted
  end
end
