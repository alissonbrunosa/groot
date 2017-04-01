require "groot/engine"

module Groot
  extend ActiveSupport::Autoload

  autoload :Exceptions
  autoload :Mapping
  autoload :AuthorityLookup
  autoload :Authority

  module Controllers
    autoload :Helpers, 'groot/controllers/helpers'
  end

  module Models
    autoload :Helpers, 'groot/models/helpers'
  end

  mattr_accessor :include_access_authority
  @@include_access_authority = false

  mattr_accessor :hmac_secret
  @@hmac_secret = nil

  mattr_accessor :algorithm
  @@algorithm = "HS256"

  mattr_reader :mapping
  @@mapping = nil

  def self.setup
    yield self
  end

  def self.mapping_to(resource)
    @@mapping ||= Mapping.new(resource)
    Controllers::Helpers.define_helpers(mapping)
    mapping
  end
end
