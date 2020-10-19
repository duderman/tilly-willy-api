# frozen_string_literal: true

RSpec.describe RecalculateDiscounts do
  subject(:call) { described_class.call([item]) }

  let(:item) { create(:checkout_item, product: product, price_cents: 100) }
  let(:product) { create(:product, price_cents: 200) }

  before do
    # because it resets items price total starts at 200
    create(:quantity_discount, product_id: item.product.id) # applies 10% first = 180
    create(:total_discount, sum_cents: 200) # skips because total isnt enough
    create(:total_discount, sum_cents: 180) # applies 10% because total is 180 = 162
    call
  end

  it 'recalculates discounts from scratch applying quantity discounts first' do
    expect(item.price.cents).to eq(162)
  end

  it 'saves items' do
    expect(item).to be_persisted
  end
end
