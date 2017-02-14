require "groot/engine"

module Groot
  extend ActiveSupport::Autoload

  autoload :Mapping

  module Controllers
    autoload :Helpers, 'groot/controllers/helpers'
    autoload :Policy,  'groot/controllers/policy'
  end

  module Models
    autoload :Helpers, 'groot/models/helpers'
  end

  module Exceptions
    autoload :ForbiddenError, 'groot/exceptions/forbidden_error'
  end

  mattr_accessor :hmac_secret
  @@hmac_secret = nil

  def self.setup
    yield self
  end

  def self.mapping(resource)
    mapping = Mapping.new(resource)
    Controllers::Helpers.define_helpers(mapping)
    mapping
  end
end
