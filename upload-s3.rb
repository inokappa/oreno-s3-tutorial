#!/usr/bin/env ruby

require 'aws-sdk-resources'

class UploadS3
  def initialize(s3_bucket, filename, presign, duration=600, vhost)
    credentials = Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
    @s3 = Aws::S3::Resource.new(region:ENV['AWS_REGION'], credentials: credentials)
    @s3_bucket = s3_bucket
    @filename = filename
    @presign = presign
    @duration = duration.to_i
    @vhost = vhost
  end
  
  def upload
    key = File.basename(@filename)
    obj = @s3.bucket(@s3_bucket).object("#{key}")
    obj.upload_file(@filename)
    unless @presign then
      obj.public_url(virtual_host: @vhost)
    else
      obj.presigned_url(:get, duration_in: @duration, virtual_host: @vhost)
    end
  end

end

s3 = UploadS3.new(ENV['S3_BUCKET'], ENV['FILE_NAME'], ENV['PRESIGN'], ENV['DURATION'], ENV['VHOST'])
puts s3.upload
