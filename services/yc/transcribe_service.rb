# frozen_string_literal: true

require 'faraday'

module Services
  module YC
    class TranscribeService < BaseService
      def initialize(audio_url)
        @audio_url = audio_url
      end

      def call
        trancribe_id = fetch_transcribe_id

        chunks = fetch_transcribe(trancribe_id)
        
        return '' if chunks&.empty?

        text = []
        chunks.each do |elem|
          text << elem['alternatives'].first['text']
        end

        text.join(' ')
      end

      private

      def fetch_transcribe(trancribe_id)
        response = loop_trancribe_request(trancribe_id)
        hash = JSON.parse response.body
        hash['response']['chunks']
      end

      def loop_trancribe_request(trancribe_id)
        done = false
        until done
          response = get_transcribe(trancribe_id)
          hash = JSON.parse response.body
          puts response
          done = hash['done']
          sleep 2
        end
        response
      end

      def get_transcribe(trancribe_id)
        Faraday.get("#{YC_GET_REC_URL}/#{trancribe_id}", nil, headers)
      end

      def fetch_transcribe_id
        response = start_transcibe
        hash = JSON.parse response.body
        hash['id']
      end

      def start_transcibe
        Faraday.post(YC_REC_URL, start_transribe_params, headers)
      end

      def headers
        { 'Authorization' => "Api-Key #{YC_SECRET_KEY}", 'Content-Type' => 'application/json' }
      end

      def start_transribe_params
        {
          'config' => {
            'specification' => {
              'languageCode' => 'ru-RU',
              'literature_text' => true,
              'model' => 'general',
              'profanityFilter' => false,
              'audioEncoding' => 'OGG_OPUS'
            }
          },
          'audio' => {
            'uri' => "https://storage.yandexcloud.net/#{AWS_BUCKET}/#{@audio_url}"
          }
        }.to_json
      end
    end
  end
end
