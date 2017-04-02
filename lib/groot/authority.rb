module Groot
	module Authority
    extend ActiveSupport::Concern

    def authorize(model, action = nil)
			action ||= params[:action]
      authority_class = AuthorityLookup.resolve(model)
			authority = authority_class.new(model, current_resource)
			raise AccessDeniedError unless authority.send(action)
    end
	end
end
