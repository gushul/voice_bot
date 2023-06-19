require 'rspec'
require 'webmock/rspec'

describe Services::BotService do
  before do
    stub_request(:post, /api.telegram.org/).to_return(status: 200, body: "", headers: {})
  end

  it 'calls ProcessVoiceService if message has voice' do
    expect(Services::ProcessVoiceService).to receive(:call)
    subject.call
  end
end


