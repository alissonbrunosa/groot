module ActionDispatch::Routing
  class Mapper
    def auth_for(resource)
      mapping = Groot.mapping_to(resource)
      constraint = lambda do |request|
        request.env['groot.mapping'] = mapping
        true
      end
      constraints(constraint) do
        auth_routes(mapping)
      end
    end

    private
      def auth_routes(mapping) #:nodoc:
        resource mapping.resource, only: [], controller: 'groot/sessions' do
          post   :create,  path: mapping.path_names[:sign_in]
          delete :destroy, path: mapping.path_names[:sign_out]
        end
      end
  end
end
