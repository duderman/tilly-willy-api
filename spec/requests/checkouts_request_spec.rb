# frozen_string_literal: true

RSpec.describe 'Checkouts', type: :request do
  describe 'GET /' do
    subject { response }

    before { post '/checkouts' }

    it { is_expected.to have_http_status(:success) }
    its(:body) { is_expected.to eq({ id: Checkout.last.id }.to_json) }

    it 'creates a checkout' do
      expect(Checkout.count).to eq(1)
    end
  end
end
