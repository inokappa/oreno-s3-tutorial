#!/usr/bin/env ruby

require 'aws-sdk-resources'

class UploadS3
  def initialize(filename)
    credentials = Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
    @s3 = Aws::S3::Resource.new(region:ENV['AWS_REGION'], credentials: credentials)
    @filename = filename
  end
  
  def upload
    key = File.basename(@filename)
    obj = @s3.bucket(ENV['S3_BUCKET']).object("#{key}")
    obj.upload_file(@filename)
    obj.public_url(virtual_host: ENV['VHOST'])
  end
end

s3 = UploadS3.new(ENV['FILE_NAME'])
p s3.upload
# puts upload_s3(ENV['FILE_NAME'])
