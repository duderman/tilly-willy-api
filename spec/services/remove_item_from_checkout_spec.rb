# frozen_string_literal: true

RSpec.describe RemoveItemFromCheckout do
  subject(:call) { described_class.call(item, checkout) }

  let(:item) { checkout.items.last }
  let(:checkout) { create(:checkout, :with_items) }

  it { is_expected.to eql(checkout) }
  it { is_expected.to be_valid }

  it 'removes a checkout item' do
    call
    expect(CheckoutItem.count).to eq(0)
  end

  it 'removes an item from the checkout' do
    expect { call }.to change { checkout.reload.items.count }.to(0)
  end

  it_behaves_like 'recalculates discounts'

  context 'when trying to remove an item from a different checkout' do
    let(:item) { create(:checkout_item) }

    before { call }

    it "doesn't delete it" do
      expect(CheckoutItem.where(id: item.id)).to exist
    end

    it "doesn't modify the checkout" do
      expect(checkout.items.count).to eq(1)
    end
  end
end
