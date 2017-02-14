module Groot
  module Models
    module Policy
      extend ActiveSupport::Concern


      module ClassMethods 
        def has_policy(attribute = :role, roles)
          raise "" if roles.empty?

          roles.each do |role|
            define_method "#{role}?" do
              self.send()

        end
      end
    end
  end
end