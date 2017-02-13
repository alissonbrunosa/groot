require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class AuthGenerator < ActiveRecord::Generators::Base
      namespace "groot:auth"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"
      source_root File.expand_path("../templates", __FILE__)

      class_option :parent, type: :string, desc: "The parent class for the generated model"

      def create_migration_file
        if(model_exists?)
          migration_template "../templates/migration/migration_existing.rb", "db/migrate/add_groot_to_#{table_name}.rb"
        else
          migration_template "../templates/migration/create_migration.rb", "db/migrate/create_#{table_name}.rb"
        end
      end

      def create_model_file
        template "model.rb", model_path unless model_exists?
      end


      private 

        def attributes_auth
<<RUBY
      t.string :email,              null: false, default: ""
      t.string :password_digest, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
RUBY
      end

        def attributes_with_index
          attributes.select { |a| !a.reference? && a.has_index? }
        end

        def model_exists?
          File.exist?(File.join(destination_root, model_path))
        end

        def model_path
          @model_path ||= File.join("app", "models", "#{file_path}.rb")
        end

        def parent_class_name
          options[:parent] || "ApplicationRecord"
        end
    end
  end
end