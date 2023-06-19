# frozen_string_literal: true

require 'dotenv/load'
require 'pry'

require_relative 'config/constants'
require_relative 'config/s3'
require_relative 'services/bot_service'

Services::BotService.call
