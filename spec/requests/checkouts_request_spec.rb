# frozen_string_literal: true

RSpec.describe 'Checkouts', type: :request do
  describe 'GET /:id' do
    subject { response }

    let(:checkout) { create(:checkout) }

    before { get "/checkouts/#{checkout.id}" }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq(CheckoutSerializer.new(checkout).to_json) }

    context "when checkout can't be found" do
      let(:checkout) { build(:checkout, id: SecureRandom.uuid) }

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  describe 'POST /' do
    subject { response }

    before { post '/checkouts' }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq(CheckoutSerializer.new(Checkout.last).to_json) }

    it 'creates a checkout' do
      expect(Checkout.count).to eq(1)
    end
  end

  describe 'DELETE /:id' do
    subject { response }

    let(:checkout) { create(:checkout) }

    before { delete "/checkouts/#{checkout.id}" }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq(CheckoutSerializer.new(Checkout.last).to_json) }

    it 'removes an old checkout' do
      expect(Checkout.where(id: checkout.id)).not_to exist
    end

    it 'creates a new checkout' do
      expect(Checkout.count).to eq(1)
    end

    context "when checkout can't be found" do
      let(:checkout) { build(:checkout, id: SecureRandom.uuid) }

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  describe 'POST /:id/add' do
    subject { response }

    let(:checkout) { create(:checkout) }
    let(:product) { create(:product) }
    let(:request) { post "/checkouts/#{checkout.id}/add", params: { product_id: product.id } }

    context 'when everything goes fine' do
      before { request }

      it { is_expected.to have_http_status(:success) }
      its(:body) { is_expected.to eq(CheckoutSerializer.new(Checkout.last).to_json) }

      it 'adds an item to checkout' do
        expect(checkout.items.count).to eq(1)
      end
    end

    context "when checkout can't be found" do
      before { post "/checkouts/#{SecureRandom.uuid}/add", params: { product_id: product.id } }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when product can't be found" do
      before { post "/checkouts/#{checkout.id}/add", params: { product_id: SecureRandom.uuid } }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when there are validation errors while trying to add a product' do
      before do
        allow(AddProductToCheckout).to receive(:call).and_raise(ActiveRecord::RecordInvalid)
        request
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
