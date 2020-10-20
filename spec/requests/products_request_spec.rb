# frozen_string_literal: true

RSpec.describe 'Products', type: :request do
  describe 'GET /' do
    subject { response }

    let!(:product) { create(:product, code: 1, name: 'Heart', price: 9.25) }

    before { get '/products' }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq([{ id: product.id, code: 1, name: 'Heart', price: 9.25, currency: 'GBP' }].to_json) }
  end
end
