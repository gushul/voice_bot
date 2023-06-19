# frozen_string_literal: true

require 'iostreams'

module Services
  module YC
    class S3UploadService < BaseService
      def initialize(file_url)
        @file_url = file_url
      end

      def call
        file_name = @file_url.split('/').last
        obj = $s3_object.new(AWS_BUCKET, file_name, client: $s3)

        IOStreams.path(@file_url).reader do |io|
          obj.upload_stream do |write_stream|
            while (data = io.read(128))
              write_stream << data
            end
          end
        end

        file_name
      end
    end
  end
end
