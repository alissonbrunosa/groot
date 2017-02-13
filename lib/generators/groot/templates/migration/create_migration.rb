class <%= migration_class_name %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :<%= table_name %><%= primary_key_type %> do |t|
<%= attributes_auth -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
    end
    
    add_index :<%= table_name %>, :email,                unique: true
    add_index :<%= table_name %>, :reset_password_token, unique: true
  end
end