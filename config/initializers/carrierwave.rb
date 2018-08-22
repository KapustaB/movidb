CarrierWave.configure do |config|
  # Configuration for Amazon S3
  config.fog_provider = 'fog/aws'                        # required

  config.fog_credentials = {
      provider:              'AWS',                         # required
      aws_access_key_id:      ENV['S3_KEY'],             # required
      aws_secret_access_key:  ENV['S3_SECRET'],          # required
      region:                 ENV['S3_REGION'],          # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = ENV['S3_BUCKET_NAME']                                  # required
  config.fog_public     = false                                                 # optional, defaults to true
  #config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}

end