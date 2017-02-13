module ActionDispatch::Routing
  class Mapper
    def auth_for(resource)
      mapping = Groot.mapping(resource)
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
        resource mapping.resource, only: [], controller: 'groot/auth' do 
          post   :create,  path: mapping.path_names[:login]
          delete :destroy, path: mapping.path_names[:logout]
        end
      end
  end
end