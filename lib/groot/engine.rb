require 'groot/rails/routes'
module Groot
  class Engine < ::Rails::Engine
    isolate_namespace Groot

    initializer "groot.add_helpers" do
      ActiveSupport.on_load(:action_controller) do
        include Controllers::Helpers
      end
    end
  end
end
