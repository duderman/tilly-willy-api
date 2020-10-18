# frozen_string_literal: true

RSpec.describe 'Products', type: :request do
  describe 'GET /' do
    subject { response }

    before do
      create(:product, code: 1, name: 'Heart', price: 9.25)
      get '/products'
    end

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq([{ code: 1, name: 'Heart', price: 9.25, currency: 'GBP' }].to_json) }
  end
end
