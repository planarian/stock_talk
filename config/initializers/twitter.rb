proxy_uri = URI(ENV["QUOTAGUARD_URL"])

proxy = {
 uri: "#{proxy_uri.host}:#{proxy_uri.port}",
 user: proxy_uri.user, 
 password: proxy_uri.password
}

::Client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["consumer_key"]
  config.consumer_secret     = ENV["consumer_secret"]
  config.access_token        = ENV["access_token"]
  config.access_token_secret = ENV["access_token_secret"]
  config.proxy = proxy
end