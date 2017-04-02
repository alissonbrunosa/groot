module Groot
  module Generators
    class AuthorityGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :authority_name, type: :string, default: "application"

      def copy_initializer_file
        if authority_name != "application"
          template "authority_template.rb", "app/authorities/#{authority_name.downcase}_authority.rb"
        else
          copy_file "authority.rb", "app/authorities/application_authority.rb"
        end
      end
    end
  end
end
