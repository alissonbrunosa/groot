require "groot/engine"

module Groot
  extend ActiveSupport::Autoload

  autoload :Mapping

  module Controllers
    autoload :Helpers, 'groot/controllers/helpers'
  end




  mattr_accessor :hmac_secret
  @@hmac_secret = nil

  def self.setup
    yield self
  end

  def self.mapping(resource)
    mapping = Mapping.new(resource)
    Controllers::Helpers.define_method(mapping)
    mapping
  end
end
