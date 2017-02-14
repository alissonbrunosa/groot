module Groot
	module Controllers
		module Policy
      extend ActiveSupport::Concern

      module ClassMethods
        def authorize(actions: [], to:, with_role:)
          options = actions.empty? ? {} : { only: actions }
          before_action(options) do 
            user = send(to)
            do_authorization(user, with_role)
          end
        end
      end

      private

      def do_authorization(user, permission)
        raise Exceptions::AccessDeniedError  unless user.has_permission?(permission)
      end
		end
	end
end