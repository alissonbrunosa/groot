module Groot
  class SessionsController < ApplicationController
    def create
      user = resource_class.find_by(email: params[:email])
      if(user && user.authenticate(params[:password]))
        render json: { user: user, access_token: encode(user) } , status: :ok
      else
        render json: { message: 'Email/Password incorrect.' }, status: :forbidden
      end
    end

    private
      def resource_class
        mapping.clazz
      end

      def mapping
        @mapping ||= request.env['groot.mapping']
      end
  end
end
