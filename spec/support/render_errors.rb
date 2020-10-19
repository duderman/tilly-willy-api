# frozen_string_literal: true

RSpec.shared_context 'with errors rendered' do
  let(:env_config) { Rails.application.env_config }
  let(:original_show_exceptions) { env_config['action_dispatch.show_exceptions'] }
  let(:original_show_detailed_exceptions) { env_config['action_dispatch.show_detailed_exceptions'] }

  before do
    env_config['action_dispatch.show_exceptions'] = true
    env_config['action_dispatch.show_detailed_exceptions'] = false
  end

  after do
    env_config['action_dispatch.show_exceptions'] = original_show_exceptions
    env_config['action_dispatch.show_detailed_exceptions'] = original_show_detailed_exceptions
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'with errors rendered', type: :request
end
