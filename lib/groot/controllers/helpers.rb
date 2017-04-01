require 'jwt'

module Groot
  module Controllers
    module Helpers
      def self.define_helpers(mapping)
        name = mapping.name
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def authenticate_#{name}!
            decode(http_token)
          end
          def #{name}_signed_in?
            !!current_#{name}
          end
          def current_#{name}
            payload = decode(http_token)
            @current_#{name} ||= #{mapping.clazz}.find(payload["sub"])
          end

          alias_method :current_resource, :current_#{name}
        METHODS

        ActiveSupport.on_load(:action_controller) do
          if respond_to?(:helper_method)
            helper_method "current_#{name}", "#{name}_signed_in?"
          end
        end
      end

      private

      def http_token
        token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
        token
      end

      def encode(resource)
        payload = {
          sub: resource.id,
          exp: (Time.now + 24.hours).to_i
        }
        JWT.encode(payload, hmac_secret, algorithm)
      end

      def decode(token)
        begin
          JWT.decode(token, hmac_secret, true, options).first
        rescue JWT::ExpiredSignature
          render json: { message: 'The token has expired.' }, status: :unauthorized
        rescue JWT::VerificationError
          render json: { message: 'Invalid access token.' }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { message: 'Invalid access token.' }, status: :unauthorized
        end
      end

      def options
        {
          algorithm: algorithm
        }
      end

      def hmac_secret
        Groot.hmac_secret
      end

      def algorithm
        Groot.algorithm
      end
    end
  end
end
