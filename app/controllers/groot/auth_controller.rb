module Groot
  class AuthController < ApplicationController

    # TODO Do something to get the real model 
    def create
      user = resource_class.find_by(email: params[:email])
      if(user && user.authenticate(params[:password]))
        render json: { user: user, access_token: encode(user) } , status: :ok
      else
        render json: { message: 'Email/Password incorrect.' }, status: :forbidden
      end
    end

    def destroy
      raise NotImplementedError
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