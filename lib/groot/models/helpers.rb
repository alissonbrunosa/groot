module Groot
  module Models
    module Helpers
      extend ActiveSupport::Concern

      module ClassMethods
        def authority_class
          "#{self}Authority".constantize
        end
      end

      def authority_class
        self.class.authority_class
      end
    end
  end
end
