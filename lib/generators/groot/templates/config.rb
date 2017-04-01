Groot.setup do |config|
  config.hmac_secret = "<%= SecureRandom.hex(64) %>"

  # Defines which algorithm will be used to encode the token
  # config.algorithm   = "HS256"

  # Set true if you want security Authority
  # config.include_access_authority = false
end
