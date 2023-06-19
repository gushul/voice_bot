# frozen_string_literal: true

TG_TOKEN = ENV['TELEGRAM_BOT_TOKEN'].freeze
TG_API_URL = "https://api.telegram.org/bot#{TG_TOKEN}".freeze
TG_FILE_URL = "https://api.telegram.org/file/bot#{TG_TOKEN}".freeze
AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID'].freeze
AWS_SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY'].freeze
AWS_REGION = 'ru-central1'
AWS_BUCKET = ENV['AWS_BUCKET_NAME'].freeze
YC_API_KEY = ENV['YC_API_KEY'].freeze
YC_SECRET_KEY = ENV['YC_SECRET_KEY'].freeze
YC_REC_URL = 'https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize'
YC_GET_REC_URL = 'https://operation.api.cloud.yandex.net/operations'
