MY_TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = Rails.application.secrets.twitter_api_key #"YOUR_CONSUMER_KEY"
  config.consumer_secret     = Rails.application.secrets.twitter_api_secret # "YOUR_CONSUMER_SECRET"
  config.access_token        = Rails.application.secrets.twitter_access_token # "YOUR_ACCESS_TOKEN"
  config.access_token_secret = Rails.application.secrets.twitter_access_token_secret # "YOUR_ACCESS_SECRET"
end