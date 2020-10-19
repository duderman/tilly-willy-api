# frozen_string_literal: true

RSpec.shared_examples 'recalculates discounts' do
  specify do
    allow(RecalculateDiscounts).to receive(:call)
    subject
    expect(RecalculateDiscounts).to have_received(:call).with(checkout.items)
  end
end
