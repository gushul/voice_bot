# frozen_string_literal: true

require 'faraday'
require 'streamio-ffmpeg'

module Services
  module Telegrams
    class FetchFileService < BaseService
      def initialize(bot, message)
        @bot = bot
        @message = message
      end

      def call
        file_info = @bot.api.get_file(file_id: @message.voice.file_id)
        file_path = file_info['result']['file_path']
        full_path = "#{TG_FILE_URL}/#{file_path}"
        file_name = file_path.split('/').last

        return full_path

        response = Faraday.get(full_path)

        local_file_path = "#{Dir.pwd}/tmp/#{file_name}"
        File.open(local_file_path, 'w') { |f| f.write(response.body) }

        target_output_file_name = "#{file_name.split('.').first}.ogg"

        convert_and_split_voice_message(local_file_path, target_output_file_name)
      end

      def convert_and_split_voice_message(voice_file_path, output_file_name)
        output_file_path = "#{Dir.pwd}/tmp/#{output_file_name}"
        command = "ffmpeg -i #{voice_file_path} -c:a libvorbis -q:a 4 #{output_file_path}"
        system(command)

        output_file_path
      end
    end
  end
end
