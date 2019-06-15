Cloudinary.config do |config|
    config.cloud_name = ENV['cloudinary_cloud']
    config.api_key = ENV['cloudinary_key']
    config.api_secret = ENV['cloudinary_secret']
end