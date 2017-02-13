class AddGrootTo<%= table_name.camelize %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def self.up
    change_table :<%= table_name %> do |t|
<%= attributes_auth -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
    end

    add_index :<%= table_name %>, :email,                unique: true
    add_index :<%= table_name %>, :reset_password_token, unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
