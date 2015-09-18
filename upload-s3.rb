#!/usr/bin/env ruby

require 'aws-sdk-resources'

def s3
  credentials = Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
  Aws::S3::Resource.new(region:ENV['AWS_REGION'], credentials: credentials)
end

def upload_s3(file_name)
  key = File.basename(file_name)
  obj = s3.bucket(ENV['S3_BUCKET']).object("#{key}")
  obj.upload_file(file_name)
  obj.public_url(virtual_host: ENV['VHOST'])
end

puts upload_s3(ENV['FILE_NAME'])
