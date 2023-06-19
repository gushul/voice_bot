# frozen_string_literal: true

module Services
  class BaseService
    def self.call(...)
      new(...).call
    end

    def call; end
  end
end
