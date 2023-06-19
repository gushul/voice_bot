# frozen_string_literal: true

require_relative 'telegrams/fetch_file_service'
require_relative 'yc/s3_upload_service'
require_relative 'yc/transcribe_service'

module Services
  class ProcessVoiceService < BaseService
    def initialize(bot, message)
      @bot = bot
      @message = message
    end

    def call
      file = fetch_file
      uploaded_file_url = upload_file(file)
      text = transcribe(uploaded_file_url)

      send_message(text)
    end

    private

    def fetch_file
      Telegrams::FetchFileService.call(@bot, @message)
    end

    def upload_file(file)
      YC::S3UploadService.call(file)
    end

    def transcribe(uploaded_file_url)
      YC::TranscribeService.call(uploaded_file_url)
    end

    def send_message(text)
      @bot.api.send_message(chat_id: @message.chat.id, text:)
    end
  end
end
