require 'groot/rails/routes'
module Groot
  class Engine < ::Rails::Engine
    isolate_namespace Groot

    initializer "groot.add_controllers_helpers" do
      ActiveSupport.on_load(:action_controller) do
        include Controllers::Helpers
        include Authority if Groot.include_access_authority
      end
    end

    initializer "groot.add_models_helpers" do
      ActiveSupport.on_load(:active_record) do
        include Models::Helpers if Groot.include_access_authority
      end
    end
  end
end
