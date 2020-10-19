# frozen_string_literal: true

RSpec.describe 'Items', type: :request, with_errors_rendered: true do
  describe 'DELETE /:id' do
    subject { response }

    let(:checkout) { create(:checkout, :with_items) }
    let(:checkout_id) { checkout.id }
    let(:item_id) { checkout.items.last.id }

    before { delete "/checkouts/#{checkout_id}/items/#{item_id}" }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq(CheckoutSerializer.new(checkout.reload).to_json) }

    it 'removes an item' do
      expect(CheckoutItem.where(id: item_id)).not_to exist
    end

    it 'removes item from checkout' do
      expect(checkout.reload.items.count).to eq(0)
    end

    context "when checkout can't be found" do
      let(:checkout_id) { SecureRandom.uuid }
      let(:item_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when item can't be found" do
      let(:item_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when item belongs to a different checkout' do
      let(:item_id) { create(:checkout_item).id }

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
