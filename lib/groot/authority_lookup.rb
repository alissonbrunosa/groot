  module Groot
    module AuthorityLookup
      class << self
        def resolve(model)
          resolve_class(model)
        rescue NameError
          ApplicationAuthority
        end

        private
        def resolve_class(model)
          return nil unless model
          return model.authority_class if model.respond_to? :authority_class
          return model.class.authority_class if model.class.respond_to? :authority_class
          return "#{model.class}Authority".constantize
        end
      end
  end
end
