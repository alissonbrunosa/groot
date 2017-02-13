module Groot
  module Generators
    class InstallGenerator < Rails::Generators::Base
      # namespace "groot:install"
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer_file
        template "config.rb", "config/initializers/groot.rb"
      end
    end
  end
end