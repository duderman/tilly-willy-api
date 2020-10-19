# frozen_string_literal: true

RSpec.describe AddProductToCheckout do
  subject(:call) { described_class.call(product, checkout) }

  let(:product) { create(:product) }
  let(:checkout) { create(:checkout) }

  it { is_expected.to eql(checkout) }
  it { is_expected.to be_valid }

  it 'creates a checkout item' do
    expect { call }.to change(CheckoutItem, :count).to(1)
  end

  it 'adds an item to the checkout' do
    expect { call }.to change { checkout.reload.items.count }.to(1)
  end

  it 'sets item price to product price' do
    call
    expect(CheckoutItem.last.price).to eq(product.price)
  end
end
