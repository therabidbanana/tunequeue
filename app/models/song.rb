class Song < AWS::S3::S3Object
  set_current_bucket_to Tunequeue::Application.config['s3']['bucket']
  
end

