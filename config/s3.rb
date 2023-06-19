# frozen_string_literal: true

require 'aws-sdk-s3'

Aws.config.update(
  region: AWS_REGION,
  credentials: Aws::Credentials.new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
)

$s3 = Aws::S3::Client.new(endpoint: 'https://storage.yandexcloud.net')
$s3_object = Aws::S3::Object
