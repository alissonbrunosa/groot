require 'jwt'

module Groot
  module Controllers
    module Helpers
      def self.define_method(mapping)
        name = mapping.name
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def authenticate_#{name}!
            decode(http_token)
          end
          def #{name}_signed_in?
            !!current_user
          end
          def current_#{name}
            payload = decode(http_token)
            @current_user ||= #{mapping.clazz}.find(payload["id"])
          end
        METHODS

        ActiveSupport.on_load(:action_controller) do
          if respond_to?(:helper_method)
            helper_method "current_#{name}", "#{name}_signed_in?"
          end
        end
      end

      private

      def http_token
        @http_token ||= request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
      end 

      def encode(resource)
        payload = {
          id: resource.id,
          exp: (Time.now + 24.hours).to_i
        }
        JWT.encode(payload, Groot.hmac_secret, 'HS256')
      end

      def decode(token)
        begin
          options = { 
            algorithm: 'HS256'
          }
          JWT.decode(token, Groot.hmac_secret, true, options).first
        rescue JWT::ExpiredSignature
          render json: { message: 'The token has expired.' }, status: :forbidden
        rescue JWT::VerificationError
          render json: { message: 'Invalid access token.' }, status: :forbidden
        rescue JWT::DecodeError
          render json: { message: 'Invalid access token.' }, status: :forbidden
        end
      end
    end
  end
end