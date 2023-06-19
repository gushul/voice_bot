require 'rspec'
require 'webmock/rspec'
# require_relative '../../services/bot_service'
# require_relative '../../services/process_voice_service'

describe Services::ProcessVoiceService do
  let(:bot) { instance_double('Telegram::Bot::Api') }
  let(:message) { instance_double('Telegram::Bot::Types::Message', voice: true) }

  before do
    stub_request(:any, /api.telegram.org/).to_return(status: 200, body: "", headers: {})
    stub_request(:any, /s3.amazonaws.com/).to_return(status: 200, body: "", headers: {})
    stub_request(:any, /transcribe.amazonaws.com/).to_return(status: 200, body: "", headers: {})
  end

  subject { described_class.new(bot, message) }

  it 'fetches file' do
    expect(Telegrams::FetchFileService).to receive(:call).with(bot, message)
    subject.call
  end

  it 'uploads file' do
    expect(YC::S3UploadService).to receive(:call)
    subject.call
  end

  it 'transcribes uploaded file' do
    expect(YC::TranscribeService).to receive(:call)
    subject.call
  end

  it 'sends message' do
    expect(bot.api).to receive(:send_message)
    subject.call
  end
end

