Groot.setup do |config|
  config.hmac_secret = "<%= SecureRandom.hex(64) %>"
end