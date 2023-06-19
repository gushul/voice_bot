# frozen_string_literal: true

require 'telegram/bot'
require_relative '../services/base_service'
require_relative '../services/process_voice_service'

module Services
  class BotService < BaseService
    def call
      puts 'Tg bot is starting...'

      Telegram::Bot::Client.run(TG_TOKEN) do |bot|
        bot.listen do |message|
          ProcessVoiceService.call(bot, message) if message.voice
        end
      end
    end
  end
end
